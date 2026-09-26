using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebBanLaptop
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] != null)
            {
                pnlChuaDangNhap.Visible = false;
                pnlDaDangNhap.Visible = true;

                lblTenNguoiDungNav.Text = Session["Fullname"] != null ? Session["Fullname"].ToString() : Session["Username"].ToString();

                string avatarFile = Session["Avatar"] != null && !string.IsNullOrEmpty(Session["Avatar"].ToString())
                                    ? Session["Avatar"].ToString()
                                    : "default-avatar.png";
                imgAvatarNav.ImageUrl = "~/Images/" + avatarFile;
            }
            else
            {
                pnlChuaDangNhap.Visible = true;
                pnlDaDangNhap.Visible = false;
            }
        }

        protected void btnDangXuatNav_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("~/Default.aspx");
        }
        protected void btnTimKiemHeader_Click(object sender, EventArgs e) 
        {
            string tuKhoa = txtTimKiemHeader.Text.Trim();
            if (!string.IsNullOrEmpty(tuKhoa))
            {
                Response.Redirect("~/Default.aspx?search=" + Server.UrlEncode(tuKhoa));
            }
            else
            {
                Response.Redirect("~/Default.aspx");
            }
        }
    }
}