using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebBanLaptop
{
    public partial class TrangHoSo : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString;

        public string GiuMoKhungMatKhau = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;

            if (Session["UserID"] == null)
            {
                Response.Redirect("TrangDangNhap.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadThongTinNguoiDung();
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

        private void HienThiThongBao(string message, bool isSuccess)
        {
            pnlThongBao.Visible = true;
            pnlThongBao.CssClass = isSuccess
                ? "alert alert-success rounded-3 py-2 small mb-4 shadow-sm"
                : "alert alert-danger rounded-3 py-2 small mb-4 shadow-sm";
            lblThongBao.Text = message;
        }

        // 1. Tải thông tin từ bảng tblUser
        private void LoadThongTinNguoiDung()
        {
            int userId = Convert.ToInt32(Session["UserID"]);

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string sql = "SELECT Username, Fullname, Phone, Email, Address, Avatar, Role FROM tblUser WHERE UserID = @UserID";
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@UserID", userId);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    string username = reader["Username"].ToString();
                    string fullname = reader["Fullname"] != DBNull.Value ? reader["Fullname"].ToString() : "";
                    string avatar = reader["Avatar"] != DBNull.Value && !string.IsNullOrEmpty(reader["Avatar"].ToString())
                                    ? reader["Avatar"].ToString()
                                    : "default-avatar.png";
                    int role = reader["Role"] != DBNull.Value ? Convert.ToInt32(reader["Role"]) : 0;

                    txtUsername.Text = username;
                    txtFullname.Text = fullname;
                    txtPhone.Text = reader["Phone"] != DBNull.Value ? reader["Phone"].ToString() : "";
                    txtEmail.Text = reader["Email"] != DBNull.Value ? reader["Email"].ToString() : "";
                    txtAddress.Text = reader["Address"] != DBNull.Value ? reader["Address"].ToString() : "";

                    lblSidebarFullname.Text = !string.IsNullOrEmpty(fullname) ? fullname : username;
                    lblSidebarUsername.Text = username;

                    // Gán đường dẫn ảnh cho cả hình tròn bên ngoài và hình phóng to trong Modal
                    imgAvatarHienTai.ImageUrl = "~/Images/Avatar/" + avatar;
                    imgAvatarModal.ImageUrl = "~/Images/Avatar/" + avatar;

                    if (role == 1)
                    {
                        lblVaiTro.Text = "Quản trị viên (Admin)";
                        lnkQuanTriAdmin.Visible = true;
                    }
                    else
                    {
                        lblVaiTro.Text = "Thành viên";
                        lnkQuanTriAdmin.Visible = false;
                    }
                }
            }
        }

        // 2. Xử lý nút LƯU ẢNH ĐẠI DIỆN trong Modal
        protected void btnLuuAvatar_Click(object sender, EventArgs e)
        {
            if (!fuAvatar.HasFile)
            {
                HienThiThongBao("Vui lòng chọn một file ảnh trước khi bấm Lưu!", false);
                return;
            }

            string ext = Path.GetExtension(fuAvatar.FileName).ToLower();
            if (ext != ".jpg" && ext != ".jpeg" && ext != ".png" && ext != ".webp")
            {
                HienThiThongBao("Chỉ chấp nhận file ảnh định dạng .JPG, .PNG hoặc .WEBP!", false);
                return;
            }

            int userId = Convert.ToInt32(Session["UserID"]);
            string avatarFileName = "avatar_" + userId + "_" + DateTime.Now.Ticks + ext;
            string savePath = Server.MapPath("~/Images/Avatar/" + avatarFileName);
            fuAvatar.SaveAs(savePath);

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string sql = "UPDATE tblUser SET Avatar = @Avatar WHERE UserID = @UserID";
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@Avatar", avatarFileName);
                cmd.Parameters.AddWithValue("@UserID", userId);

                conn.Open();
                cmd.ExecuteNonQuery();
            }

            // Cập nhật lại Session và làm mới trang để ảnh trên thanh Navbar đổi ngay lập tức
            Session["Avatar"] = avatarFileName;
            Response.Redirect(Request.RawUrl);
        }

        // 3. Xử lý nút LƯU THAY ĐỔI thông tin cá nhân
        protected void btnCapNhatHoSo_Click(object sender, EventArgs e)
        {
            Page.Validate("vgHoSo");
            if (!Page.IsValid) return;

            int userId = Convert.ToInt32(Session["UserID"]);
            string fullname = txtFullname.Text.Trim();
            string phone = txtPhone.Text.Trim();
            string email = txtEmail.Text.Trim();
            string address = txtAddress.Text.Trim();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string sql = @"UPDATE tblUser 
                               SET Fullname = @Fullname, 
                                   Phone = @Phone, 
                                   Email = @Email, 
                                   Address = @Address 
                               WHERE UserID = @UserID";

                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@Fullname", fullname);
                cmd.Parameters.AddWithValue("@Phone", phone);
                cmd.Parameters.AddWithValue("@Email", string.IsNullOrEmpty(email) ? (object)DBNull.Value : email);
                cmd.Parameters.AddWithValue("@Address", string.IsNullOrEmpty(address) ? (object)DBNull.Value : address);
                cmd.Parameters.AddWithValue("@UserID", userId);

                conn.Open();
                cmd.ExecuteNonQuery();
            }

            Session["Fullname"] = fullname;
            LoadThongTinNguoiDung();
            HienThiThongBao("Cập nhật thông tin hồ sơ thành công!", true);
        }

        // 4. Xử lý ĐỔI MẬT KHẨU
        protected void btnDoiMatKhau_Click(object sender, EventArgs e)
        {
            GiuMoKhungMatKhau = "show"; // Giữ khung mở khi PostBack

            Page.Validate("vgMatKhau");
            if (!Page.IsValid) return;

            int userId = Convert.ToInt32(Session["UserID"]);
            string matKhauCuMD5 = MaHoaMD5(txtMatKhauCu.Text.Trim());
            string matKhauMoiMD5 = MaHoaMD5(txtMatKhauMoi.Text.Trim());

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                string checkSql = "SELECT COUNT(*) FROM tblUser WHERE UserID = @UserID AND Password = @OldPass";
                SqlCommand checkCmd = new SqlCommand(checkSql, conn);
                checkCmd.Parameters.AddWithValue("@UserID", userId);
                checkCmd.Parameters.AddWithValue("@OldPass", matKhauCuMD5);

                int match = (int)checkCmd.ExecuteScalar();
                if (match == 0)
                {
                    HienThiThongBao("Mật khẩu hiện tại không chính xác!", false);
                    return;
                }

                string updateSql = "UPDATE tblUser SET Password = @NewPass WHERE UserID = @UserID";
                SqlCommand updateCmd = new SqlCommand(updateSql, conn);
                updateCmd.Parameters.AddWithValue("@NewPass", matKhauMoiMD5);
                updateCmd.Parameters.AddWithValue("@UserID", userId);
                updateCmd.ExecuteNonQuery();

                GiuMoKhungMatKhau = "";
                HienThiThongBao("Đổi mật khẩu thành công!", true);
            }
        }
    }
}