using System;
using System.Data;
using System.Web.UI.WebControls;

namespace WebBanLaptop
{
    public partial class GioHang : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                HienThiGioHang();
            }
        }

        private void HienThiGioHang()
        {
            DataTable dt = Session["GioHang"] as DataTable;

            // Kiểm tra nếu giỏ hàng trống hoặc Session không tồn tại
            if (dt == null || dt.Rows.Count == 0)
            {
                pnlGioHangTrong.Visible = true;
                pnlDanhSachGioHang.Visible = false;
                return;
            }

            // Nếu có hàng, hiển thị GridView
            pnlGioHangTrong.Visible = false;
            pnlDanhSachGioHang.Visible = true;

            gvGioHang.DataSource = dt;
            gvGioHang.DataBind();

            // Tính tổng tiền
            decimal tongTien = 0;
            foreach (DataRow row in dt.Rows)
            {
                tongTien += Convert.ToDecimal(row["ThanhTien"]);
            }
            lblTongTien.Text = string.Format("{0:N0} đ", tongTien);
        }

        protected void gvGioHang_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            DataTable dt = Session["GioHang"] as DataTable;
            if (dt == null) return;

            // Xử lý sự kiện XÓA SẢN PHẨM
            if (e.CommandName == "Xoa")
            {
                string maSP = e.CommandArgument.ToString();
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    if (dt.Rows[i]["MaSanPham"].ToString() == maSP)
                    {
                        dt.Rows.RemoveAt(i);
                        break;
                    }
                }
            }
            // Xử lý sự kiện CẬP NHẬT SỐ LƯỢNG
            else if (e.CommandName == "CapNhat")
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument);
                GridViewRow gvRow = gvGioHang.Rows[rowIndex];
                TextBox txtSoLuong = (TextBox)gvRow.FindControl("txtSoLuong");

                int soLuongMoi;
                if (int.TryParse(txtSoLuong.Text, out soLuongMoi) && soLuongMoi > 0)
                {
                    // Cập nhật số lượng mới vào DataTable
                    dt.Rows[rowIndex]["SoLuong"] = soLuongMoi;
                    // Cột ThanhTien sẽ tự động tính lại (DonGia * SoLuong) nếu bạn đã set biểu thức Expression lúc tạo bảng
                }
            }

            // Lưu lại bảng mới vào Session và tải lại lưới
            Session["GioHang"] = dt;
            HienThiGioHang();
        }

        protected void btnCapNhatTatCa_Click(object sender, EventArgs e)
        {
            // Lấy bảng giỏ hàng hiện tại ra
            DataTable dt = Session["GioHang"] as DataTable;
            if (dt == null) return;

            // Duyệt qua từng dòng (Row) đang hiển thị trên giao diện GridView
            foreach (GridViewRow row in gvGioHang.Rows)
            {
                // 1. Tìm cái ô TextBox nhập số lượng ở dòng hiện tại
                TextBox txtSoLuong = (TextBox)row.FindControl("txtSoLuong");

                // 2. Lấy con số mà người dùng vừa gõ vào
                int soLuongMoi;
                if (int.TryParse(txtSoLuong.Text, out soLuongMoi) && soLuongMoi > 0)
                {
                    // 3. Cập nhật lại số lượng đó vào bảng DataTable ở Server
                    // Thuộc tính RowIndex của GridViewRow khớp với chỉ số dòng của DataTable
                    dt.Rows[row.RowIndex]["SoLuong"] = soLuongMoi;

                    // Cột ThanhTien sẽ tự tính do lúc tạo DataTable ta có dùng biểu thức (DonGia * SoLuong)
                }
            }

            // Lưu lại Session mới và tải lại lưới để hiển thị Tổng tiền mới nhất
            Session["GioHang"] = dt;
            HienThiGioHang();
        }

        protected void btnThanhToan_Click(object sender, EventArgs e)
        {
            Response.Redirect("ThanhToan.aspx");
        }
    }
}