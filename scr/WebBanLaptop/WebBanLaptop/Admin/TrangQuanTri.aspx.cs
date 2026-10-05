using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace WebBanLaptop.Admin
{
    public partial class TrangQuanTri : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString;

        // Biến truyền dữ liệu ra biểu đồ Chart.js
        public string ChuoiDoanhThu12Thang = "";
        public string ChuoiTyLeDonHang = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            /*
            if (Session["UserID"] == null || Session["Role"] == null || Convert.ToInt32(Session["Role"]) != 1)
            {
                Response.Redirect("~/TrangDangNhap.aspx");
                return;
            }
            */

            if (!IsPostBack)
            {
                int namHienTai = DateTime.Now.Year;
                if (ddlNamThongKe.Items.FindByValue(namHienTai.ToString()) == null)
                {
                    ddlNamThongKe.Items.Insert(0, new ListItem("Năm " + namHienTai, namHienTai.ToString()));
                }
                ddlNamThongKe.SelectedValue = namHienTai.ToString();

                LoadToanBoDuLieu(namHienTai);
            }
        }

        protected void ddlNamThongKe_SelectedIndexChanged(object sender, EventArgs e)
        {
            int nam = Convert.ToInt32(ddlNamThongKe.SelectedValue);
            LoadToanBoDuLieu(nam);
        }

        private void LoadToanBoDuLieu(int nam)
        {
            LoadThongKeTongQuan(nam);
            LoadBieuDoDoanhThu(nam);
            LoadBieuDoTrangThai(nam);
            LoadDonHangMoi();
            LoadHangBanChay(nam);
        }

        // 1. Load 4 ô thẻ Tổng quan
        private void LoadThongKeTongQuan(int nam)
        {
            string sql = @"
                SELECT 
                    (SELECT ISNULL(SUM(TongTien), 0) FROM tblDonHang WHERE YEAR(NgayTao) = @Nam AND TrangThai <> 3) AS TongDoanhThu,
                    (SELECT COUNT(*) FROM tblDonHang WHERE YEAR(NgayTao) = @Nam) AS TongDonHang,
                    (SELECT COUNT(*) FROM tblSanPham WHERE TrangThai = 1) AS TongSanPham,
                    (SELECT COUNT(*) FROM tblUser WHERE Role = 0) AS TongKhachHang";

            using (SqlConnection conn = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand(sql, conn))
            {
                cmd.Parameters.AddWithValue("@Nam", nam);
                conn.Open();
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        decimal doanhThu = Convert.ToDecimal(reader["TongDoanhThu"]);
                        lblTongDoanhThu.Text = doanhThu.ToString("N0") + " đ";
                        lblTongDonHang.Text = reader["TongDonHang"].ToString();
                        lblTongSanPham.Text = reader["TongSanPham"].ToString();
                        lblTongKhachHang.Text = reader["TongKhachHang"].ToString();
                    }
                }
            }
        }

        // 2. Load dữ liệu Biểu đồ Cột (Doanh thu 12 tháng)
        private void LoadBieuDoDoanhThu(int nam)
        {
            decimal[] doanhThuThang = new decimal[12];
            string sql = @"
                SELECT MONTH(NgayTao) AS Thang, SUM(TongTien) AS DoanhThu 
                FROM tblDonHang 
                WHERE YEAR(NgayTao) = @Nam AND TrangThai <> 3
                GROUP BY MONTH(NgayTao)";

            using (SqlConnection conn = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand(sql, conn))
            {
                cmd.Parameters.AddWithValue("@Nam", nam);
                conn.Open();
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        int thang = Convert.ToInt32(reader["Thang"]);
                        // Đưa về đơn vị Triệu VNĐ cho biểu đồ dễ nhìn
                        doanhThuThang[thang - 1] = Convert.ToDecimal(reader["DoanhThu"]) / 1000000;
                    }
                }
            }
            ChuoiDoanhThu12Thang = string.Join(", ", doanhThuThang);
        }

        // 3. Load dữ liệu Biểu đồ Tròn (Trạng thái đơn hàng)
        private void LoadBieuDoTrangThai(int nam)
        {
            int[] tyLe = new int[4] { 0, 0, 0, 0 };
            string sql = @"
                SELECT TrangThai, COUNT(*) AS SoLuong 
                FROM tblDonHang 
                WHERE YEAR(NgayTao) = @Nam 
                GROUP BY TrangThai";

            using (SqlConnection conn = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand(sql, conn))
            {
                cmd.Parameters.AddWithValue("@Nam", nam);
                conn.Open();
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        int trangThai = reader["TrangThai"] != DBNull.Value ? Convert.ToInt32(reader["TrangThai"]) : 0;
                        int sl = Convert.ToInt32(reader["SoLuong"]);

                        if (trangThai == 2) tyLe[0] = sl;      // Đã giao
                        else if (trangThai == 1) tyLe[1] = sl; // Đang vận chuyển
                        else if (trangThai == 0) tyLe[2] = sl; // Chờ xác nhận
                        else if (trangThai == 3) tyLe[3] = sl; // Đã hủy
                    }
                }
            }
            ChuoiTyLeDonHang = string.Join(", ", tyLe);
        }

        // 4. Load GridView Đơn hàng mới nhất
        private void LoadDonHangMoi()
        {
            string sql = @"
                SELECT TOP 15 
                    '#' + CAST(MaDonHang AS VARCHAR) AS MaDH, 
                    HoTenNguoiNhan AS KhachHang, 
                    NgayTao AS NgayDat, 
                    TongTien, 
                    CASE TrangThai 
                        WHEN 0 THEN N'Chờ xác nhận' 
                        WHEN 1 THEN N'Đang vận chuyển' 
                        WHEN 2 THEN N'Đã giao' 
                        WHEN 3 THEN N'Đã hủy' 
                        ELSE N'Chờ xác nhận' 
                    END AS TrangThai
                FROM tblDonHang
                ORDER BY NgayTao DESC";

            using (SqlConnection conn = new SqlConnection(connStr))
            using (SqlDataAdapter da = new SqlDataAdapter(sql, conn))
            {
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvDonHangMoi.DataSource = dt;
                gvDonHangMoi.DataBind();
            }
        }

        protected void gvDonHangMoi_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvDonHangMoi.PageIndex = e.NewPageIndex;
            LoadDonHangMoi();
        }

        public string LayMauTrangThai(string trangThai)
        {
            switch (trangThai)
            {
                case "Đã giao": return "bg-success";
                case "Đang vận chuyển": return "bg-primary";
                case "Chờ xác nhận": return "bg-warning text-dark";
                default: return "bg-danger"; // Đã hủy
            }
        }

        // 5. Load Repeater Hãng bán chạy và tính % Progress Bar
        private void LoadHangBanChay(int nam)
        {
            string sql = @"
                SELECT TOP 5 
                    th.TenThuongHieu AS TenHang, 
                    ISNULL(SUM(ct.SoLuong), 0) AS SoLuong
                FROM tblChiTietDonHang ct
                JOIN tblSanPham sp ON ct.MaSanPham = sp.MaSanPham
                JOIN tblThuongHieu th ON sp.MaThuongHieu = th.MaThuongHieu
                JOIN tblDonHang dh ON ct.MaDonHang = dh.MaDonHang
                WHERE YEAR(dh.NgayTao) = @Nam AND dh.TrangThai <> 3
                GROUP BY th.TenThuongHieu
                ORDER BY SoLuong DESC";

            using (SqlConnection conn = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand(sql, conn))
            {
                cmd.Parameters.AddWithValue("@Nam", nam);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                // Tính tổng sản phẩm đã bán trong năm để ra Tỷ lệ %
                int tongSanPhamBanDuoc = 0;
                string sqlTotal = "SELECT ISNULL(SUM(ct.SoLuong), 0) FROM tblChiTietDonHang ct JOIN tblDonHang dh ON ct.MaDonHang = dh.MaDonHang WHERE YEAR(dh.NgayTao) = @Nam AND dh.TrangThai <> 3";
                using (SqlCommand cmdTotal = new SqlCommand(sqlTotal, conn))
                {
                    cmdTotal.Parameters.AddWithValue("@Nam", nam);
                    conn.Open();
                    tongSanPhamBanDuoc = Convert.ToInt32(cmdTotal.ExecuteScalar());
                }

                dt.Columns.Add("TyLe", typeof(int));
                foreach (DataRow row in dt.Rows)
                {
                    int sl = Convert.ToInt32(row["SoLuong"]);
                    row["TyLe"] = (tongSanPhamBanDuoc > 0) ? (int)Math.Round((double)sl / tongSanPhamBanDuoc * 100) : 0;
                }

                rptHangBanChay.DataSource = dt;
                rptHangBanChay.DataBind();
            }
        }
    }
}