using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebBanLaptop
{
    public partial class ChiTietSanPham : Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int maSanPham;
                if (int.TryParse(Request.QueryString["id"], out maSanPham))
                {
                    LoadChiTietSanPham(maSanPham);
                    LoadHinhAnhSanPham(maSanPham);
                }
                else
                {
                    // Nếu không có id hợp lệ trên URL thì quay về trang chủ
                    Response.Redirect("Default.aspx");
                }
            }
        }

        // 1. Tải thông tin sản phẩm + Thông số kỹ thuật
        private void LoadChiTietSanPham(int maSanPham)
        {
            string sql = @"
                SELECT 
                    sp.MaSanPham, sp.TenSanPham, sp.MaDanhMuc, sp.MaThuongHieu,
                    sp.GiaGoc, sp.GiaKhuyenMai, sp.SoLuongTon, sp.MoTa, sp.AnhDaiDien,
                    dm.TenDanhMuc, th.TenThuongHieu,
                    ts.CPU, ts.RAM, ts.OCung, ts.CardDoHoa, ts.ManHinh, 
                    ts.DoPhanGiai, ts.TanSoQuet, ts.HeDieuHanh, ts.TrongLuong, ts.Pin, ts.MauSac
                FROM tblSanPham sp
                LEFT JOIN tblDanhMuc dm ON sp.MaDanhMuc = dm.MaDanhMuc
                LEFT JOIN tblThuongHieu th ON sp.MaThuongHieu = th.MaThuongHieu
                LEFT JOIN tblThongSoKyThuat ts ON sp.MaSanPham = ts.MaSanPham
                WHERE sp.MaSanPham = @MaSanPham AND sp.TrangThai = 1";

            using (SqlConnection conn = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand(sql, conn))
            {
                cmd.Parameters.AddWithValue("@MaSanPham", maSanPham);
                conn.Open();

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        string tenSP = reader["TenSanPham"].ToString();
                        int maDanhMuc = Convert.ToInt32(reader["MaDanhMuc"]);
                        decimal giaGoc = Convert.ToDecimal(reader["GiaGoc"]);
                        decimal giaKM = reader["GiaKhuyenMai"] != DBNull.Value ? Convert.ToDecimal(reader["GiaKhuyenMai"]) : 0;
                        int soLuongTon = Convert.ToInt32(reader["SoLuongTon"]);

                        // Tiêu đề trang & Breadcrumb
                        Page.Title = tenSP;
                        litBreadcrumbTenSP.Text = tenSP;
                        lnkBreadcrumbDanhMuc.Text = reader["TenDanhMuc"].ToString();
                        lnkBreadcrumbDanhMuc.NavigateUrl = "~/Default.aspx?danhmuc=" + maDanhMuc;

                        // Thông tin cơ bản
                        litTenSanPham.Text = tenSP;
                        litThuongHieu.Text = reader["TenThuongHieu"].ToString();
                        litDanhMuc.Text = reader["TenDanhMuc"].ToString();
                        imgAnhChinh.ImageUrl = reader["AnhDaiDien"].ToString();
                        litMoTa.Text = reader["MoTa"] != DBNull.Value ? reader["MoTa"].ToString() : "Đang cập nhật mô tả.";

                        // Xử lý hiển thị Giá & Khuyến mãi
                        if (giaKM > 0 && giaKM < giaGoc)
                        {
                            litGiaHienThi.Text = string.Format("{0:N0}đ", giaKM);
                            litGiaGoc.Text = string.Format("{0:N0}đ", giaGoc);
                            int phanTramGiam = (int)Math.Round((giaGoc - giaKM) * 100 / giaGoc);
                            litPhanTramGiam.Text = phanTramGiam.ToString();
                            pnlGiaGoc.Visible = true;
                        }
                        else
                        {
                            litGiaHienThi.Text = string.Format("{0:N0}đ", giaGoc);
                            pnlGiaGoc.Visible = false;
                        }

                        // Kiểm tra tồn kho
                        litSoLuongTon.Text = soLuongTon.ToString();
                        if (soLuongTon > 0)
                        {
                            lblTinhTrang.Text = "Còn hàng";
                            lblTinhTrang.CssClass = "badge bg-success";
                            pnlMuaHang.Visible = true;
                        }
                        else
                        {
                            lblTinhTrang.Text = "Tạm hết hàng";
                            lblTinhTrang.CssClass = "badge bg-secondary";
                            pnlMuaHang.Visible = false;
                        }

                        // Bảng Thông số kỹ thuật
                        string cpu = GetSafeString(reader["CPU"]);
                        string ram = GetSafeString(reader["RAM"]);
                        string oCung = GetSafeString(reader["OCung"]);
                        string vga = GetSafeString(reader["CardDoHoa"]);

                        litTomTatCPU.Text = cpu;
                        litTomTatRAM.Text = ram;
                        litTomTatOCung.Text = oCung;
                        litTomTatVGA.Text = vga;

                        litCPU.Text = cpu;
                        litRAM.Text = ram;
                        litOCung.Text = oCung;
                        litCardDoHoa.Text = vga;
                        litManHinh.Text = GetSafeString(reader["ManHinh"]);
                        litDoPhanGiai.Text = GetSafeString(reader["DoPhanGiai"]);
                        litTanSoQuet.Text = GetSafeString(reader["TanSoQuet"]);
                        litHeDieuHanh.Text = GetSafeString(reader["HeDieuHanh"]);
                        litTrongLuong.Text = GetSafeString(reader["TrongLuong"]);
                        litPin.Text = GetSafeString(reader["Pin"]);
                        litMauSac.Text = GetSafeString(reader["MauSac"]);

                        // Tải sản phẩm liên quan cùng danh mục
                        LoadSanPhamLienQuan(maDanhMuc, maSanPham);
                    }
                    else
                    {
                        Response.Redirect("Default.aspx");
                    }
                }
            }
        }

        // 2. Tải danh sách hình ảnh thu nhỏ từ bảng tblHinhAnhSanPham
        private void LoadHinhAnhSanPham(int maSanPham)
        {
            string sql = "SELECT DuongDanAnh FROM tblHinhAnhSanPham WHERE MaSanPham = @MaSanPham ORDER BY LaAnhChinh DESC";
            using (SqlConnection conn = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand(sql, conn))
            {
                cmd.Parameters.AddWithValue("@MaSanPham", maSanPham);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptHinhAnh.DataSource = dt;
                rptHinhAnh.DataBind();
            }
        }

        // 3. Tải 4 sản phẩm tương tự cùng Danh mục
        private void LoadSanPhamLienQuan(int maDanhMuc, int maSanPhamHienTai)
        {
            string sql = @"
                SELECT TOP 4 
                    MaSanPham, TenSanPham, AnhDaiDien,
                    CASE 
                        WHEN GiaKhuyenMai IS NOT NULL AND GiaKhuyenMai > 0 AND GiaKhuyenMai < GiaGoc 
                        THEN GiaKhuyenMai 
                        ELSE GiaGoc 
                    END AS GiaHienThi
                FROM tblSanPham
                WHERE TrangThai = 1 AND MaDanhMuc = @MaDanhMuc AND MaSanPham <> @MaSanPham
                ORDER BY MaSanPham DESC";

            using (SqlConnection conn = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand(sql, conn))
            {
                cmd.Parameters.AddWithValue("@MaDanhMuc", maDanhMuc);
                cmd.Parameters.AddWithValue("@MaSanPham", maSanPhamHienTai);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptSanPhamLienQuan.DataSource = dt;
                rptSanPhamLienQuan.DataBind();
            }
        }

        // 4. Sự kiện nút THÊM VÀO GIỎ
        protected void btnThemVaoGio_Click(object sender, EventArgs e)
        {
            ThemSanPhamVaoGio();
            lblThongBao.Text = "<i class='bi bi-check-circle-fill me-1'></i> Đã thêm sản phẩm vào giỏ hàng thành công!";
            lblThongBao.CssClass = "d-block mt-3 text-success fw-semibold";
            lblThongBao.Visible = true;
        }

        // 5. Sự kiện nút MUA NGAY 
        protected void btnMuaNgay_Click(object sender, EventArgs e)
        {
            ThemSanPhamVaoGio();
            Response.Redirect("GioHang.aspx");
        }

        private void ThemSanPhamVaoGio()
        {
            // 1. Lấy thông tin mã sản phẩm và số lượng
            int maSanPham = Convert.ToInt32(Request.QueryString["id"]);
            int soLuongMua = 1;

            // Nếu có ô nhập số lượng thì lấy, không thì mặc định là 1
            if (txtSoLuong != null)
            {
                int.TryParse(txtSoLuong.Text, out soLuongMua);
            }
            if (soLuongMua <= 0) soLuongMua = 1;

            // 2. LUÔN DÙNG SESSION ĐỂ LƯU GIỎ HÀNG (Dù đã đăng nhập hay chưa)
            DataTable dtGioHang = Session["GioHang"] as DataTable;

            if (dtGioHang == null)
            {
                dtGioHang = new DataTable();
                dtGioHang.Columns.Add("MaSanPham", typeof(int));
                dtGioHang.Columns.Add("TenSanPham", typeof(string));
                dtGioHang.Columns.Add("AnhDaiDien", typeof(string));
                dtGioHang.Columns.Add("DonGia", typeof(decimal));
                dtGioHang.Columns.Add("SoLuong", typeof(int));
                dtGioHang.Columns.Add("ThanhTien", typeof(decimal), "DonGia * SoLuong"); 
            }

            // 3. Kiểm tra sản phẩm đã có trong giỏ chưa
            DataRow[] rows = dtGioHang.Select("MaSanPham = " + maSanPham);
            if (rows.Length > 0)
            {
                rows[0]["SoLuong"] = Convert.ToInt32(rows[0]["SoLuong"]) + soLuongMua;
            }
            else
            {
                string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    string sqlGetProduct = "SELECT TenSanPham, AnhDaiDien, GiaGoc FROM tblSanPham WHERE MaSanPham = @MaSanPham";
                    using (SqlCommand cmd = new SqlCommand(sqlGetProduct, conn))
                    {
                        cmd.Parameters.AddWithValue("@MaSanPham", maSanPham);
                        conn.Open();
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                string tenSP = reader["TenSanPham"].ToString();
                                string anh = reader["AnhDaiDien"].ToString();

                                decimal gia = Convert.ToDecimal(reader["GiaGoc"]);

                                dtGioHang.Rows.Add(maSanPham, tenSP, anh, gia, soLuongMua);
                            }
                        }
                    }
                }
            }

            // 4. Cập nhật lại Session
            Session["GioHang"] = dtGioHang;

        }

        private string GetSafeString(object value)
        {
            return value != DBNull.Value && !string.IsNullOrEmpty(value.ToString()) ? value.ToString() : "Đang cập nhật";
        }

    }
}