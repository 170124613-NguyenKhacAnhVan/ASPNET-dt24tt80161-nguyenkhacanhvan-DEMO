using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebBanLaptop
{
    public partial class TrangDangNhap : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["register"] == "success")
                {
                    pnlThongBao.Visible = true;
                    pnlThongBao.CssClass = "alert alert-success rounded-3 py-2 small mb-3";
                    lblThongBao.Text = "<i class='bi bi-check-circle-fill me-1'></i> Đăng ký tài khoản thành công! Mời bạn đăng nhập.";
                }
            }
        }

        private string MaHoaMD5(string input)
        {
            using (MD5 md5 = MD5.Create())
            {
                byte[] hashBytes = md5.ComputeHash(Encoding.UTF8.GetBytes(input));
                return BitConverter.ToString(hashBytes).Replace("-", "").ToLower();
            }
        }
        protected void btnDangNhap_Click(object sender, EventArgs e)
        {
            Page.Validate("vgLogin");
            if (!Page.IsValid) return;

            string username = txtUsername.Text.Trim();
            string passwordMD5 = MaHoaMD5(txtPassword.Text.Trim());

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string sql = @"SELECT UserID, Username, Fullname, Role, Status, Avatar
                               FROM tblUser 
                               WHERE Username = @Username AND Password = @Password";

                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@Username", username);
                cmd.Parameters.AddWithValue("@Password", passwordMD5);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    int status = reader["Status"] != DBNull.Value ? Convert.ToInt32(reader["Status"]) : 1;
                    if (status == 0)
                    {
                        pnlThongBao.Visible = true;
                        pnlThongBao.CssClass = "alert alert-warning rounded-3 py-2 small mb-3";
                        lblThongBao.Text = "Tài khoản của bạn hiện đang bị khóa!";
                        return;
                    }

                    Session["UserID"] = reader["UserID"];
                    Session["Username"] = reader["Username"].ToString();
                    Session["Fullname"] = reader["Fullname"] != DBNull.Value ? reader["Fullname"].ToString() : username;
                    Session["Role"] = reader["Role"] != DBNull.Value ? Convert.ToInt32(reader["Role"]) : 0;
                    Session["Avatar"] = reader["Avatar"] != DBNull.Value && !string.IsNullOrEmpty(reader["Avatar"].ToString()) ? reader["Avatar"].ToString() : "default-avatar.png";

                    if (Convert.ToInt32(Session["Role"]) == 1)
                        Response.Redirect("~/Admin/TrangQuanTri.aspx");
                    else
                        Response.Redirect("Default.aspx");
                }
                else
                {
                    pnlThongBao.Visible = true;
                    pnlThongBao.CssClass = "alert alert-danger rounded-3 py-2 small mb-3";
                    lblThongBao.Text = "Tên đăng nhập hoặc mật khẩu không chính xác!";
                }
            }
        }
    }
}