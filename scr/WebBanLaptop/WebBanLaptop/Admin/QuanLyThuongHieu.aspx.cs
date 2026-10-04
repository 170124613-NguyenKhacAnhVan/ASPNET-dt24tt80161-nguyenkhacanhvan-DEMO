using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebBanLaptop.Admin
{
    public partial class QuanLyThuonghieu : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
            if (!IsPostBack)
            {
                LoadDanhSach();
            }
        }

        private void HienThiThongBao(string message, bool isSuccess)
        {
            pnlThongBao.Visible = true;
            pnlThongBao.CssClass = isSuccess
                ? "alert alert-success rounded-3 py-2 small mb-3 shadow-sm"
                : "alert alert-danger rounded-3 py-2 small mb-3 shadow-sm";
            lblThongBao.Text = message;
        }

        private void LoadDanhSach()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string sql = "SELECT * FROM tblThuonghieu WHERE 1=1";
                if (!string.IsNullOrWhiteSpace(txtTimKiem.Text))
                {
                    sql += " AND TenThuonghieu LIKE @Keyword";
                }
                sql += " ORDER BY MaThuonghieu DESC";

                SqlCommand cmd = new SqlCommand(sql, conn);
                if (!string.IsNullOrWhiteSpace(txtTimKiem.Text))
                {
                    cmd.Parameters.AddWithValue("@Keyword", "%" + txtTimKiem.Text.Trim() + "%");
                }

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvDanhSach.DataSource = dt;
                gvDanhSach.DataBind();
            }
        }

        protected void btnTimKiem_Click(object sender, EventArgs e)
        {
            gvDanhSach.PageIndex = 0;
            LoadDanhSach();
        }

        protected void btnMoFormThem_Click(object sender, EventArgs e)
        {
            XoaTrangForm();
            lblTieuDeForm.Text = "THÊM DANH MỤC MỚI";
            pnlForm.Visible = true;
            pnlThongBao.Visible = false;
        }

        protected void btnHuyForm_Click(object sender, EventArgs e)
        {
            pnlForm.Visible = false;
            XoaTrangForm();
        }

        private void XoaTrangForm()
        {
            hfMaThuonghieu.Value = "";
            hfLogoCu.Value = "";
            txtTenThuonghieu.Text = "";
            txtMoTa.Text = "";
            ddlTrangThai.SelectedValue = "1";
            imgPreview.ImageUrl = "~/Images/no-image.png";
        }

        protected void btnLuu_Click(object sender, EventArgs e)
        {
            Page.Validate("vgForm");
            if (!Page.IsValid) return;

            string Logo = string.IsNullOrEmpty(hfLogoCu.Value) ? "" : hfLogoCu.Value;

            // Xử lý upload ảnh
            if (fuLogo.HasFile)
            {
                string ext = Path.GetExtension(fuLogo.FileName).ToLower();
                if (ext == ".jpg" || ext == ".jpeg" || ext == ".png" || ext == ".webp")
                {
                    Logo = "dm_" + DateTime.Now.Ticks + ext;
                    fuLogo.SaveAs(Server.MapPath("~/Images/Thuonghieu/" + Logo));
                }
            }

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                string sql = "";

                if (string.IsNullOrEmpty(hfMaThuonghieu.Value)) // Thêm mới
                {
                    sql = "INSERT INTO tblThuonghieu (TenThuonghieu, MoTa, Logo, TrangThai) VALUES (@Ten, @MoTa, @Logo, @TrangThai)";
                }
                else // Cập nhật
                {
                    sql = "UPDATE tblThuonghieu SET TenThuonghieu=@Ten, MoTa=@MoTa, Logo=@Logo, TrangThai=@TrangThai WHERE MaThuonghieu=@Ma";
                }

                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@Ten", txtTenThuonghieu.Text.Trim());
                cmd.Parameters.AddWithValue("@MoTa", txtMoTa.Text.Trim());
                cmd.Parameters.AddWithValue("@Logo", Logo);
                cmd.Parameters.AddWithValue("@TrangThai", Convert.ToInt32(ddlTrangThai.SelectedValue));

                if (!string.IsNullOrEmpty(hfMaThuonghieu.Value))
                {
                    cmd.Parameters.AddWithValue("@Ma", Convert.ToInt32(hfMaThuonghieu.Value));
                }

                cmd.ExecuteNonQuery();
            }

            pnlForm.Visible = false;
            LoadDanhSach();
            HienThiThongBao("Đã lưu thông tin danh mục thành công!", true);
        }

        protected void gvDanhSach_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "SuaRecord")
            {
                XoaTrangForm();
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    SqlCommand cmd = new SqlCommand("SELECT * FROM tblThuonghieu WHERE MaThuonghieu = @Ma", conn);
                    cmd.Parameters.AddWithValue("@Ma", id);
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        hfMaThuonghieu.Value = reader["MaThuonghieu"].ToString();
                        txtTenThuonghieu.Text = reader["TenThuonghieu"].ToString();
                        txtMoTa.Text = reader["MoTa"].ToString();
                        ddlTrangThai.SelectedValue = reader["TrangThai"].ToString();

                        string anh = reader["Logo"].ToString();
                        hfLogoCu.Value = anh;
                        imgPreview.ImageUrl = string.IsNullOrEmpty(anh) ? "~/Images/no-image.png" : "~/Images/Thuonghieu/" + anh;
                    }
                }
                lblTieuDeForm.Text = "CẬP NHẬT DANH MỤC (#" + id + ")";
                pnlForm.Visible = true;
                pnlThongBao.Visible = false;
            }
            else if (e.CommandName == "XoaRecord")
            {
                try
                {
                    using (SqlConnection conn = new SqlConnection(connStr))
                    {
                        SqlCommand cmd = new SqlCommand("DELETE FROM tblThuonghieu WHERE MaThuonghieu = @Ma", conn);
                        cmd.Parameters.AddWithValue("@Ma", id);
                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                    LoadDanhSach();
                    HienThiThongBao("Đã xóa danh mục thành công!", true);
                }
                catch
                {
                    HienThiThongBao("Không thể xóa do danh mục này đang chứa sản phẩm!", false);
                }
            }
        }

        protected void gvDanhSach_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvDanhSach.PageIndex = e.NewPageIndex;
            LoadDanhSach();
        }
    }
}