using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace WebBanLaptop
{
    public partial class ThanhToan : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                HienThiDonHang();
            }
        }

        // Tách riêng hàm hiển thị để code Page_Load dễ đọc hơn
        private void HienThiDonHang()
        {
            DataTable dt = Session["GioHang"] as DataTable;

            // Nếu không có giỏ hàng, đá về trang Giỏ hàng
            if (dt == null || dt.Rows.Count == 0)
            {
                Response.Redirect("GioHang.aspx");
                return;
            }

            // 1. Đổ dữ liệu ra danh sách Repeater bên cột phải
            rptDonHang.DataSource = dt;
            rptDonHang.DataBind();

            // 2. Tính tổng tiền và hiển thị
            decimal tongTien = TinhTongTien(dt);
            lblTongThanhToan.Text = string.Format("{0:N0} đ", tongTien);
        }

        private decimal TinhTongTien(DataTable dt)
        {
            decimal tong = 0;
            foreach (DataRow row in dt.Rows)
            {
                tong += Convert.ToDecimal(row["ThanhTien"]);
            }
            return tong;
        }

        protected void btnDatHang_Click(object sender, EventArgs e)
        {
            DataTable dtGioHang = Session["GioHang"] as DataTable;
            if (dtGioHang == null || dtGioHang.Rows.Count == 0) return;

            decimal tongTien = TinhTongTien(dtGioHang);
            object userID = Session["UserID"] ?? (object)DBNull.Value;

            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                using (SqlTransaction transaction = conn.BeginTransaction())
                {
                    try
                    {
                        // BƯỚC 1: LƯU ĐƠN HÀNG
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
                        cmdDonHang.Parameters.AddWithValue("@TrangThai", 0); // 0 = Chờ duyệt
                        cmdDonHang.Parameters.AddWithValue("@PhuongThuc", ddlPhuongThuc.SelectedValue);
                        cmdDonHang.Parameters.AddWithValue("@NgayTao", DateTime.Now);

                        int maDonHang = Convert.ToInt32(cmdDonHang.ExecuteScalar());

                        // BƯỚC 2: LƯU CHI TIẾT ĐƠN HÀNG
                        string sqlChiTiet = @"
                            INSERT INTO tblChiTietDonHang (MaDonHang, MaSanPham, SoLuong, DonGia) 
                            VALUES (@MaDonHang, @MaSanPham, @SoLuong, @DonGia)";

                        foreach (DataRow row in dtGioHang.Rows)
                        {
                            SqlCommand cmdChiTiet = new SqlCommand(sqlChiTiet, conn, transaction);
                            cmdChiTiet.Parameters.AddWithValue("@MaDonHang", maDonHang);
                            cmdChiTiet.Parameters.AddWithValue("@MaSanPham", row["MaSanPham"]);
                            cmdChiTiet.Parameters.AddWithValue("@SoLuong", row["SoLuong"]);
                            cmdChiTiet.Parameters.AddWithValue("@DonGia", row["DonGia"]);

                            cmdChiTiet.ExecuteNonQuery();
                        }

                        // XÁC NHẬN LƯU THÀNH CÔNG
                        transaction.Commit();

                        // Chuyển đổi giao diện
                        Session["GioHang"] = null;
                        pnlFormDatHang.Visible = false;
                        pnlThanhCong.Visible = true;
                    }
                    catch (Exception ex)
                    {
                        transaction.Rollback();
                        // Hiển thị Popup lỗi thực tế để dễ fix bug
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Lỗi đặt hàng: {ex.Message}');", true);
                    }
                }
            }
        }
    }
}