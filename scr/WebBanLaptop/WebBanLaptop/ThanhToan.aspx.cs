using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace WebBanLaptop
{
    public partial class ThanhToan : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DataTable dt = Session["GioHang"] as DataTable;
                if (dt == null || dt.Rows.Count == 0)
                {
                    Response.Redirect("GioHang.aspx");
                    return;
                }

                // Tính tổng tiền hiển thị lên form
                decimal tongTien = 0;
                foreach (DataRow row in dt.Rows)
                {
                    tongTien += Convert.ToDecimal(row["ThanhTien"]);
                }
                lblTongThanhToan.Text = string.Format("{0:N0} đ", tongTien);
            }
        }

        protected void btnDatHang_Click(object sender, EventArgs e)
        {
            DataTable dtGioHang = Session["GioHang"] as DataTable;
            if (dtGioHang == null || dtGioHang.Rows.Count == 0) return;

            // 1. Tính tổng tiền từ giỏ hàng
            decimal tongTien = 0;
            foreach (DataRow row in dtGioHang.Rows)
            {
                tongTien += Convert.ToDecimal(row["ThanhTien"]);
            }

            // 2. Lấy UserID (Giả sử bạn lưu ID người dùng khi đăng nhập bằng Session["UserID"])
            // Nếu hệ thống cho phép khách mua không cần đăng nhập, có thể truyền null (DB của bạn cho phép UserID có thể NULL)
            object userID = Session["UserID"] ?? (object)DBNull.Value;

            // 3. Kết nối SQL và thực hiện Transaction (Đảm bảo lưu đủ cả Đơn hàng & Chi tiết, nếu lỗi sẽ tự hoàn tác)
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString; // Nhớ đổi tên chuỗi kết nối

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                using (SqlTransaction transaction = conn.BeginTransaction())
                {
                    try
                    {
                        // BƯỚC 1: LƯU VÀO BẢNG tblDonHang
                        // Dùng SCOPE_IDENTITY() để lấy ngay MaDonHang vừa được tự động sinh ra
                        string sqlDonHang = @"
                            INSERT INTO tblDonHang (UserID, HoTenNguoiNhan, SoDienThoai, DiaChiGiaoHang, TongTien, TrangThai, PhuongThucThanhToan, NgayTao) 
                            VALUES (@UserID, @HoTen, @SDT, @DiaChi, @TongTien, @TrangThai, @PhuongThuc, @NgayTao);
                            SELECT SCOPE_IDENTITY();";

                        SqlCommand cmdDonHang = new SqlCommand(sqlDonHang, conn, transaction);
                        cmdDonHang.Parameters.AddWithValue("@UserID", userID);
                        cmdDonHang.Parameters.AddWithValue("@HoTen", txtHoTen.Text.Trim());
                        cmdDonHang.Parameters.AddWithValue("@SDT", txtSoDienThoai.Text.Trim());
                        cmdDonHang.Parameters.AddWithValue("@DiaChi", txtDiaChi.Text.Trim());
                        cmdDonHang.Parameters.AddWithValue("@TongTien", tongTien);
                        cmdDonHang.Parameters.AddWithValue("@TrangThai", 0); // 0 = Chờ duyệt/Mới đặt
                        cmdDonHang.Parameters.AddWithValue("@PhuongThuc", ddlPhuongThuc.SelectedValue);
                        cmdDonHang.Parameters.AddWithValue("@NgayTao", DateTime.Now);

                        // Lấy mã đơn hàng vừa sinh
                        int maDonHang = Convert.ToInt32(cmdDonHang.ExecuteScalar());

                        // BƯỚC 2: LƯU VÀO BẢNG tblChiTietDonHang
                        string sqlChiTiet = @"
                            INSERT INTO tblChiTietDonHang (MaDonHang, MaSanPham, SoLuong, DonGia) 
                            VALUES (@MaDonHang, @MaSanPham, @SoLuong, @DonGia)";

                        foreach (DataRow row in dtGioHang.Rows)
                        {
                            SqlCommand cmdChiTiet = new SqlCommand(sqlChiTiet, conn, transaction);
                            cmdChiTiet.Parameters.AddWithValue("@MaDonHang", maDonHang);
                            // Nhớ đảm bảo trong Session["GioHang"] bạn đã đặt tên cột là MaSanPham
                            cmdChiTiet.Parameters.AddWithValue("@MaSanPham", row["MaSanPham"]);
                            cmdChiTiet.Parameters.AddWithValue("@SoLuong", row["SoLuong"]);
                            cmdChiTiet.Parameters.AddWithValue("@DonGia", row["DonGia"]);

                            cmdChiTiet.ExecuteNonQuery();
                        }

                        transaction.Commit();

                        // 4. Hoàn tất: Xóa giỏ hàng và hiện thông báo
                        Session["GioHang"] = null;
                        pnlFormDatHang.Visible = false;
                        pnlThanhCong.Visible = true;
                    }
                    catch (Exception ex)
                    {
                        // Nếu có bất kỳ lỗi gì (VD: mất mạng, sai kiểu dữ liệu), hủy bỏ lưu trữ (Rollback)
                        transaction.Rollback();
                        // Có thể in ra log hoặc hiển thị lỗi cho người dùng: 
                        // Response.Write("<script>alert('Lỗi đặt hàng: " + ex.Message + "');</script>");
                    }
                }
            }
        }
    }
}