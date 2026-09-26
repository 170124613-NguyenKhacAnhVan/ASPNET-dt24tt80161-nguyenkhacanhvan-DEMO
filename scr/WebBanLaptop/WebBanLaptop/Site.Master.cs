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