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
    public partial class _Default : Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadThuongHieu();
                LoadDanhMuc();
                LoadKhuyenMaiHot();
                LoadDanhMucVaSanPham();
            }
        }
        // 1. Tải danh sách Thương hiệu lên rptThuongHieu
        private void LoadThuongHieu()
        {
            string sql = "SELECT MaThuongHieu, TenThuongHieu, Logo FROM tblThuongHieu WHERE TrangThai = 1";
            rptThuongHieu.DataSource = GetData(sql);
            rptThuongHieu.DataBind();
        }

        // 2. Tải danh sách Danh mục lên rptDanhMuc
        private void LoadDanhMuc()
        {
            string sql = "SELECT MaDanhMuc, TenDanhMuc, HinhAnh FROM tblDanhMuc WHERE TrangThai = 1";
            rptDanhMuc.DataSource = GetData(sql);
            rptDanhMuc.DataBind();
        }

        // 3. Tải 4 sản phẩm giảm giá nhiều nhất lên rptKhuyenMai
        private void LoadKhuyenMaiHot()
        {
            if (!string.IsNullOrEmpty(Request.QueryString["danhmuc"]) || !string.IsNullOrEmpty(Request.QueryString["thuonghieu"]))
            {
                pnlKhuyenMai.Visible = false;
                return;
            }

            string sql = @"
                SELECT TOP 4 
                    MaSanPham, TenSanPham, AnhDaiDien, GiaGoc, GiaKhuyenMai,
                    CAST(ROUND((GiaGoc - GiaKhuyenMai) * 100.0 / NULLIF(GiaGoc, 0), 0) AS INT) AS PhanTramGiam
                FROM tblSanPham
                WHERE TrangThai = 1 
                  AND GiaKhuyenMai IS NOT NULL 
                  AND GiaKhuyenMai > 0 
                  AND GiaKhuyenMai < GiaGoc
                ORDER BY PhanTramGiam DESC";

            rptKhuyenMai.DataSource = GetData(sql);
            rptKhuyenMai.DataBind();
        }

        // 4. Tải các khối Danh mục 
        private void LoadDanhMucVaSanPham()
        {
            string maDanhMucFilter = Request.QueryString["danhmuc"];
            string maThuongHieuFilter = Request.QueryString["thuonghieu"];

            string sql = @"
                SELECT DISTINCT dm.MaDanhMuc, dm.TenDanhMuc
                FROM tblDanhMuc dm
                INNER JOIN tblSanPham sp ON dm.MaDanhMuc = sp.MaDanhMuc
                WHERE dm.TrangThai = 1 AND sp.TrangThai = 1";

            using (SqlConnection conn = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.Connection = conn;

                if (!string.IsNullOrEmpty(maDanhMucFilter))
                {
                    sql += " AND dm.MaDanhMuc = @MaDanhMuc";
                    cmd.Parameters.AddWithValue("@MaDanhMuc", maDanhMucFilter);
                }

                if (!string.IsNullOrEmpty(maThuongHieuFilter))
                {
                    sql += " AND sp.MaThuongHieu = @MaThuongHieu";
                    cmd.Parameters.AddWithValue("@MaThuongHieu", maThuongHieuFilter);
                }

                sql += " ORDER BY dm.MaDanhMuc ASC";
                cmd.CommandText = sql;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptDanhMucSanPham.DataSource = dt;
                rptDanhMucSanPham.DataBind();
            }
        }

        // 5. Sự kiện nạp danh sách Sản phẩm + Thông số kỹ thuật cho từng Danh mục
        protected void rptDanhMucSanPham_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                HiddenField hfMaDanhMuc = (HiddenField)e.Item.FindControl("hfMaDanhMuc");
                Repeater rptSanPhamTheoDanhMuc = (Repeater)e.Item.FindControl("rptSanPhamTheoDanhMuc");

                string maThuongHieuFilter = Request.QueryString["thuonghieu"];

                string sql = @"
                    SELECT TOP 4
                        sp.MaSanPham, sp.TenSanPham, sp.AnhDaiDien, sp.GiaGoc, sp.GiaKhuyenMai,
                        CASE 
                            WHEN sp.GiaKhuyenMai IS NOT NULL AND sp.GiaKhuyenMai > 0 AND sp.GiaKhuyenMai < sp.GiaGoc 
                            THEN sp.GiaKhuyenMai 
                            ELSE sp.GiaGoc 
                        END AS GiaHienThi,
                        ISNULL(ts.CPU, N'Đang cập nhật') AS CPU,
                        ISNULL(ts.RAM, N'Đang cập nhật') AS RAM,
                        ISNULL(ts.CardDoHoa, N'Onboard') AS CardDoHoa
                    FROM tblSanPham sp
                    LEFT JOIN tblThongSoKyThuat ts ON sp.MaSanPham = ts.MaSanPham
                    WHERE sp.TrangThai = 1 AND sp.MaDanhMuc = @MaDanhMuc";

                using (SqlConnection conn = new SqlConnection(connStr))
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = conn;
                    cmd.Parameters.AddWithValue("@MaDanhMuc", hfMaDanhMuc.Value);

                    if (!string.IsNullOrEmpty(maThuongHieuFilter))
                    {
                        sql += " AND sp.MaThuongHieu = @MaThuongHieu";
                        cmd.Parameters.AddWithValue("@MaThuongHieu", maThuongHieuFilter);
                    }

                    sql += " ORDER BY sp.MaSanPham DESC";
                    cmd.CommandText = sql;

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    rptSanPhamTheoDanhMuc.DataSource = dt;
                    rptSanPhamTheoDanhMuc.DataBind();
                }
            }
        }

        // Hàm dùng chung để lấy DataTable
        private DataTable GetData(string sql)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            using (SqlDataAdapter da = new SqlDataAdapter(sql, conn))
            {
                DataTable dt = new DataTable();
                da.Fill(dt);
                return dt;
            }
        }

    }
}