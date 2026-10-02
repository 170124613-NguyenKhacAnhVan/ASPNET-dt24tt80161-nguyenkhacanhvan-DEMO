using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace WebBanLaptop.Admin
{
    public partial class QuanLyTaiKhoan : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) LoadUsers();
        }

        private void LoadUsers()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM tblUser ORDER BY UserID DESC", conn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvTaiKhoan.DataSource = dt;
                gvTaiKhoan.DataBind();
            }
        }

        protected void btnMoFormThem_Click(object sender, EventArgs e)
        {
            hfUserID.Value = "";
            txtUsername.Text = "";
            txtUsername.Enabled = true; // Cho phép nhập User mới
            txtPassword.Text = "";
            txtFullname.Text = "";
            txtPhone.Text = "";
            txtEmail.Text = "";
            ddlRole.SelectedValue = "0";
            ddlStatus.SelectedValue = "1";
            pnlForm.Visible = true;
        }

        protected void btnHuyForm_Click(object sender, EventArgs e) => pnlForm.Visible = false;

        protected void gvTaiKhoan_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "SuaUser")
            {
                int userID = Convert.ToInt32(e.CommandArgument);
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    SqlCommand cmd = new SqlCommand("SELECT * FROM tblUser WHERE UserID = @ID", conn);
                    cmd.Parameters.AddWithValue("@ID", userID);
                    conn.Open();
                    SqlDataReader r = cmd.ExecuteReader();
                    if (r.Read())
                    {
                        hfUserID.Value = r["UserID"].ToString();
                        txtUsername.Text = r["Username"].ToString();
                        txtUsername.Enabled = false; // Không cho sửa tên đăng nhập
                        txtPassword.Text = ""; // Để trống nếu không muốn đổi pass
                        txtFullname.Text = r["Fullname"].ToString();
                        txtPhone.Text = r["Phone"].ToString();
                        txtEmail.Text = r["Email"].ToString();
                        ddlRole.SelectedValue = r["Role"].ToString();
                        ddlStatus.SelectedValue = r["Status"].ToString();
                    }
                }
                pnlForm.Visible = true;
            }
        }

        protected void btnLuu_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = conn;

                if (string.IsNullOrEmpty(hfUserID.Value))
                {
                    // Thêm mới
                    cmd.CommandText = "INSERT INTO tblUser (Username, Password, Fullname, Phone, Email, Role, Status) VALUES (@Username, @Password, @Fullname, @Phone, @Email, @Role, @Status)";
                    cmd.Parameters.AddWithValue("@Username", txtUsername.Text.Trim());
                    cmd.Parameters.AddWithValue("@Password", txtPassword.Text.Trim()); // Thực tế nên mã hóa MD5/SHA256
                }
                else
                {
                    // Sửa (Nếu txtPassword có nhập thì đổi pass, không thì giữ nguyên)
                    if (!string.IsNullOrEmpty(txtPassword.Text.Trim()))
                    {
                        cmd.CommandText = "UPDATE tblUser SET Password=@Password, Fullname=@Fullname, Phone=@Phone, Email=@Email, Role=@Role, Status=@Status WHERE UserID=@ID";
                        cmd.Parameters.AddWithValue("@Password", txtPassword.Text.Trim());
                    }
                    else
                    {
                        cmd.CommandText = "UPDATE tblUser SET Fullname=@Fullname, Phone=@Phone, Email=@Email, Role=@Role, Status=@Status WHERE UserID=@ID";
                    }
                    cmd.Parameters.AddWithValue("@ID", hfUserID.Value);
                }

                cmd.Parameters.AddWithValue("@Fullname", txtFullname.Text.Trim());
                cmd.Parameters.AddWithValue("@Phone", txtPhone.Text.Trim());
                cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                cmd.Parameters.AddWithValue("@Role", ddlRole.SelectedValue);
                cmd.Parameters.AddWithValue("@Status", ddlStatus.SelectedValue);

                cmd.ExecuteNonQuery();
            }

            pnlForm.Visible = false;
            LoadUsers();
            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Đã lưu thông tin tài khoản!');", true);
        }
    }
}