using System;

namespace WebBanLaptop.Admin
{
    public partial class Admin : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Kiểm tra quyền Admin chung cho toàn bộ các trang dùng Admin.Master
            if (Session["UserID"] == null || Session["Role"] == null || Convert.ToInt32(Session["Role"]) != 1)
            {
                Response.Redirect("~/TrangDangNhap.aspx");
                return;
            }

            if (!IsPostBack)
            {
                lblAdminName.Text = Session["Fullname"] != null ? Session["Fullname"].ToString() : Session["Username"].ToString();

                string avatar = Session["Avatar"] != null && !string.IsNullOrEmpty(Session["Avatar"].ToString())
                                ? Session["Avatar"].ToString()
                                : "default-avatar.png";
                imgAdminAvatar.ImageUrl = "~/Images/" + avatar;
            }
        }

        protected void btnDangXuatAdmin_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("~/TrangDangNhap.aspx");
        }
    }
}