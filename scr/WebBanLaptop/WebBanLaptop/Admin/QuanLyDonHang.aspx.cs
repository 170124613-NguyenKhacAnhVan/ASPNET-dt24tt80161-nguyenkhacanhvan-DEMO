using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace WebBanLaptop.Admin
{
    public partial class QuanLyDonHang : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) LoadDonHang();
        }

        private void LoadDonHang()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string sql = "SELECT * FROM tblDonHang WHERE 1=1";
                if (!string.IsNullOrWhiteSpace(txtTimKiem.Text))
                    sql += " AND (HoTenNguoiNhan LIKE @Key OR SoDienThoai LIKE @Key)";
                if (ddlLocTrangThai.SelectedValue != "-1")
                    sql += " AND TrangThai = @TrangThai";

                sql += " ORDER BY NgayTao DESC";

                SqlCommand cmd = new SqlCommand(sql, conn);
                if (!string.IsNullOrWhiteSpace(txtTimKiem.Text))
                    cmd.Parameters.AddWithValue("@Key", "%" + txtTimKiem.Text.Trim() + "%");
                if (ddlLocTrangThai.SelectedValue != "-1")
                    cmd.Parameters.AddWithValue("@TrangThai", ddlLocTrangThai.SelectedValue);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvDonHang.DataSource = dt;
                gvDonHang.DataBind();
            }
        }

        protected void BoLoc_Changed(object sender, EventArgs e) => LoadDonHang();

        protected void gvDonHang_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "XemChiTiet")
            {
                int maDon = Convert.ToInt32(e.CommandArgument);
                lblMaDonHang.Text = maDon.ToString();

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    // 1. Lấy thông tin chung
                    SqlCommand cmd = new SqlCommand("SELECT * FROM tblDonHang WHERE MaDonHang = @Ma", conn);
                    cmd.Parameters.AddWithValue("@Ma", maDon);
                    conn.Open();
                    SqlDataReader r = cmd.ExecuteReader();
                    if (r.Read())
                    {
                        lblKhachHang.Text = r["HoTenNguoiNhan"].ToString();
                        lblSDT.Text = r["SoDienThoai"].ToString();
                        lblDiaChi.Text = r["DiaChiGiaoHang"].ToString();
                        lblNgayDat.Text = Convert.ToDateTime(r["NgayTao"]).ToString("dd/MM/yyyy HH:mm");
                        lblPhuongThuc.Text = r["PhuongThucThanhToan"].ToString();
                        lblGhiChu.Text = r["GhiChu"].ToString();
                        lblTongTienDon.Text = Convert.ToDecimal(r["TongTien"]).ToString("N0") + " đ";
                        ddlCapNhatTrangThai.SelectedValue = r["TrangThai"].ToString();
                    }
                    r.Close();

                    // 2. Lấy danh sách sản phẩm (JOIN với bảng tblSanPham để lấy tên và ảnh)
                    string sqlChiTiet = @"SELECT sp.TenSanPham, sp.AnhDaiDien, ct.SoLuong, ct.DonGia, (ct.SoLuong * ct.DonGia) AS ThanhTien 
                                          FROM tblChiTietDonHang ct 
                                          INNER JOIN tblSanPham sp ON ct.MaSanPham = sp.MaSanPham 
                                          WHERE ct.MaDonHang = @Ma";
                    SqlDataAdapter da = new SqlDataAdapter(new SqlCommand(sqlChiTiet, conn) { Parameters = { new SqlParameter("@Ma", maDon) } });
                    DataTable dtChiTiet = new DataTable();
                    da.Fill(dtChiTiet);
                    gvChiTiet.DataSource = dtChiTiet;
                    gvChiTiet.DataBind();
                }
                pnlDanhSach.Visible = false;
                pnlChiTiet.Visible = true;
            }
        }

        protected void btnDongChiTiet_Click(object sender, EventArgs e)
        {
            pnlChiTiet.Visible = false;
            pnlDanhSach.Visible = true;
            LoadDonHang();
        }

        protected void btnLuuTrangThai_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("UPDATE tblDonHang SET TrangThai = @TrangThai WHERE MaDonHang = @Ma", conn);
                cmd.Parameters.AddWithValue("@TrangThai", ddlCapNhatTrangThai.SelectedValue);
                cmd.Parameters.AddWithValue("@Ma", lblMaDonHang.Text);
                conn.Open();
                cmd.ExecuteNonQuery();
            }
            // Hiện thông báo bằng JS
            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Cập nhật trạng thái thành công!');", true);
        }
    }
}