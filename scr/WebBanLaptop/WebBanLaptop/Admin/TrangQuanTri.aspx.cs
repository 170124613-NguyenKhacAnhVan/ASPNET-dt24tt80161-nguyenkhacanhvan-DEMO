using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebBanLaptop.Admin
{
    public partial class TrangQuanTri : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString;

        // 2 biến public truyền số liệu sang biểu đồ Chart.js ngoài giao diện
        public string ChuoiDoanhThu12Thang = "120, 150, 180, 140, 210, 250, 230, 290, 320, 280, 350, 410";
        public string ChuoiTyLeDonHang = "65, 20, 10, 5";

        protected void Page_Load(object sender, EventArgs e)
        {
            // Kiểm tra quyền Admin (Role == 1 mới được vào)
            if (Session["UserID"] == null || Session["Role"] == null || Convert.ToInt32(Session["Role"]) != 1)
            {
                Response.Redirect("~/TrangDangNhap.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadThongKeTongQuan();
                LoadDonHangMoi();
                LoadHangBanChay();
            }
        }

        // 1. Tải 4 ô thống kê tổng quan
        private void LoadThongKeTongQuan()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                string sqlUser = "SELECT COUNT(*) FROM tblUser WHERE Role = 0";
                SqlCommand cmdUser = new SqlCommand(sqlUser, conn);
                int tongKhach = (int)cmdUser.ExecuteScalar();
                lblTongKhachHang.Text = tongKhach.ToString("N0");

                // Các chỉ số Doanh thu, Đơn hàng, Sản phẩm (Bạn có thể thay bằng SELECT COUNT/SUM từ bảng thực tế của bạn)
                lblTongDoanhThu.Text = "2.930.000.000 đ";
                lblTongDonHang.Text = "148";
                lblTongSanPham.Text = "42";
            }
        }

        // 2. Đổ dữ liệu vào GridView Đơn hàng mới nhất
        private void LoadDonHangMoi()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("MaDH");
            dt.Columns.Add("KhachHang");
            dt.Columns.Add("NgayDat", typeof(DateTime));
            dt.Columns.Add("TongTien", typeof(decimal));
            dt.Columns.Add("TrangThai");

            // Dữ liệu mẫu hiển thị trên GridView (Khi có bảng tblOrder bạn chỉ cần dùng SqlDataAdapter.Fill(dt))
            dt.Rows.Add("#DH1025", "Nguyễn Văn An", DateTime.Now, 24500000, "Chờ xác nhận");
            dt.Rows.Add("#DH1024", "Trần Thị Bích", DateTime.Now.AddDays(-1), 18900000, "Đang vận chuyển");
            dt.Rows.Add("#DH1023", "Lê Hoàng Nam", DateTime.Now.AddDays(-2), 32000000, "Đã giao");
            dt.Rows.Add("#DH1022", "Phạm Minh Tuấn", DateTime.Now.AddDays(-3), 15490000, "Đã giao");
            dt.Rows.Add("#DH1021", "Hoàng Gia Bảo", DateTime.Now.AddDays(-4), 21000000, "Đã hủy");
            dt.Rows.Add("#DH1020", "Đặng Thu Thảo", DateTime.Now.AddDays(-5), 27800000, "Đã giao");

            gvDonHangMoi.DataSource = dt;
            gvDonHangMoi.DataBind();
        }

        // Sự kiện chuyển trang của GridView
        protected void gvDonHangMoi_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvDonHangMoi.PageIndex = e.NewPageIndex;
            LoadDonHangMoi();
        }

        // Hàm tô màu Badge trạng thái trong GridView
        public string LayMauTrangThai(string trangThai)
        {
            switch (trangThai)
            {
                case "Đã giao": return "bg-success";
                case "Đang vận chuyển": return "bg-primary";
                case "Chờ xác nhận": return "bg-warning text-dark";
                default: return "bg-danger";
            }
        }

        // 3. Đổ dữ liệu vào Repeater + Progress Bar
        private void LoadHangBanChay()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("TenHang");
            dt.Columns.Add("SoLuong");
            dt.Columns.Add("TyLe");

            dt.Rows.Add("ASUS ROG / TUF Gaming", 54, 38);
            dt.Rows.Add("Dell Inspiron / XPS", 42, 28);
            dt.Rows.Add("Lenovo Legion / LOQ", 28, 19);
            dt.Rows.Add("Acer Nitro / Predator", 15, 10);
            dt.Rows.Add("MSI Gaming", 9, 5);

            rptHangBanChay.DataSource = dt;
            rptHangBanChay.DataBind();
        }

        // 4. Sự kiện khi đổi Năm thống kê trên DropDownList
        protected void ddlNamThongKe_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlNamThongKe.SelectedValue == "2025")
            {
                ChuoiDoanhThu12Thang = "95, 110, 130, 125, 160, 190, 175, 210, 240, 220, 260, 310";
                ChuoiTyLeDonHang = "70, 15, 5, 10";
                lblTongDoanhThu.Text = "2.225.000.000 đ";
                lblTongDonHang.Text = "112";
            }
            else
            {
                LoadThongKeTongQuan();
            }
        }
    }
}