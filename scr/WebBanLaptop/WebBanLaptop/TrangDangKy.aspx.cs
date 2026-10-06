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
    public partial class TrangDangKy : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        private string MaHoaMD5(string input)
        {
            using (MD5 md5 = MD5.Create())
            {
                byte[] hashBytes = md5.ComputeHash(Encoding.UTF8.GetBytes(input));
                return BitConverter.ToString(hashBytes).Replace("-", "").ToLower();
            }
        }

        private void BaoLoi(string message)
        {
            pnlThongBao.Visible = true;
            lblThongBao.Text = message;
        }

        protected void btnDangKy_Click(object sender, EventArgs e)
        {
            Page.Validate("vgRegister");
            if (!Page.IsValid) return;

            string username = txtUsername.Text.Trim();
            string fullname = txtFullname.Text.Trim();
            string phone = txtPhone.Text.Trim();
            string email = txtEmail.Text.Trim();
            string address = txtAddress.Text.Trim();
            string passwordMD5 = MaHoaMD5(txtPassword.Text.Trim());

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                string checkSql = "SELECT COUNT(*) FROM tblUser WHERE Username = @Username";
                SqlCommand checkCmd = new SqlCommand(checkSql, conn);
                checkCmd.Parameters.AddWithValue("@Username", username);
                int exists = (int)checkCmd.ExecuteScalar();

                if (exists > 0)
                {
                    BaoLoi("Tên đăng nhập này đã có người sử dụng, vui lòng chọn tên khác!");
                    return;
                }

                string insertSql = @"INSERT INTO tblUser 
                                     (Username, Password, Fullname, Address, Status, Role, Avatar, Email, Phone) 
                                     VALUES 
                                     (@Username, @Password, @Fullname, @Address, 1, 0, @Avatar, @Email, @Phone)";

                SqlCommand cmd = new SqlCommand(insertSql, conn);
                cmd.Parameters.AddWithValue("@Username", username);
                cmd.Parameters.AddWithValue("@Password", passwordMD5);
                cmd.Parameters.AddWithValue("@Fullname", fullname);
                cmd.Parameters.AddWithValue("@Address", string.IsNullOrEmpty(address) ? (object)DBNull.Value : address);
                cmd.Parameters.AddWithValue("@Avatar", "user.png");
                cmd.Parameters.AddWithValue("@Email", string.IsNullOrEmpty(email) ? (object)DBNull.Value : email);
                cmd.Parameters.AddWithValue("@Phone", phone);

                int rows = cmd.ExecuteNonQuery();
                if (rows > 0)
                {
                    Response.Redirect("TrangDangNhap.aspx?register=success");
                }
                else
                {
                    BaoLoi("Đăng ký không thành công, vui lòng thử lại!");
                }
            }
        }
    }
}