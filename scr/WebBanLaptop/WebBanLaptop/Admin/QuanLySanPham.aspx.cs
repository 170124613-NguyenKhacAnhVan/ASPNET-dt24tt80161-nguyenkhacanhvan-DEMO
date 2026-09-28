using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebBanLaptop.Admin
{
    public partial class QuanLySanPham : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;

            if (!IsPostBack)
            {
                LoadDanhMucVaThuongHieu();
                LoadDanhSachSanPham();
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

        // Load danh mục và thương hiệu lên các dropdown
        private void LoadDanhMucVaThuongHieu()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlDataAdapter daDM = new SqlDataAdapter("SELECT MaDanhMuc, TenDanhMuc FROM tblDanhMuc", conn);
                DataTable dtDM = new DataTable();
                daDM.Fill(dtDM);

                ddlDanhMuc.DataSource = dtDM;
                ddlDanhMuc.DataTextField = "TenDanhMuc";
                ddlDanhMuc.DataValueField = "MaDanhMuc";
                ddlDanhMuc.DataBind();

                ddlLocDanhMuc.DataSource = dtDM;
                ddlLocDanhMuc.DataTextField = "TenDanhMuc";
                ddlLocDanhMuc.DataValueField = "MaDanhMuc";
                ddlLocDanhMuc.DataBind();
                ddlLocDanhMuc.Items.Insert(0, new ListItem("-- Tất cả danh mục --", "0"));

                SqlDataAdapter daTH = new SqlDataAdapter("SELECT MaThuongHieu, TenThuongHieu FROM tblThuongHieu", conn);
                DataTable dtTH = new DataTable();
                daTH.Fill(dtTH);

                ddlThuongHieu.DataSource = dtTH;
                ddlThuongHieu.DataTextField = "TenThuongHieu";
                ddlThuongHieu.DataValueField = "MaThuongHieu";
                ddlThuongHieu.DataBind();

                ddlLocThuongHieu.DataSource = dtTH;
                ddlLocThuongHieu.DataTextField = "TenThuongHieu";
                ddlLocThuongHieu.DataValueField = "MaThuongHieu";
                ddlLocThuongHieu.DataBind();
                ddlLocThuongHieu.Items.Insert(0, new ListItem("-- Tất cả thương hiệu --", "0"));
            }
        }

        // Lấy danh sách sản phẩm kèm lọc tìm kiếm
        private void LoadDanhSachSanPham()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string sql = @"SELECT sp.MaSanPham, sp.TenSanPham, sp.GiaGoc, sp.GiaKhuyenMai, 
                                      sp.SoLuongTon, sp.AnhDaiDien, sp.TrangThai,
                                      dm.TenDanhMuc, th.TenThuongHieu,
                                      ts.CPU, ts.RAM, ts.OCung, ts.CardDoHoa
                               FROM tblSanPham sp
                               LEFT JOIN tblDanhMuc dm ON sp.MaDanhMuc = dm.MaDanhMuc
                               LEFT JOIN tblThuongHieu th ON sp.MaThuongHieu = th.MaThuongHieu
                               LEFT JOIN tblThongSoKyThuat ts ON sp.MaSanPham = ts.MaSanPham
                               WHERE 1 = 1";

                SqlCommand cmd = new SqlCommand();
                cmd.Connection = conn;

                if (!string.IsNullOrWhiteSpace(txtTimKiem.Text))
                {
                    sql += " AND (sp.TenSanPham LIKE @Keyword OR ts.CPU LIKE @Keyword)";
                    cmd.Parameters.AddWithValue("@Keyword", "%" + txtTimKiem.Text.Trim() + "%");
                }

                if (ddlLocDanhMuc.SelectedIndex > 0 && ddlLocDanhMuc.SelectedValue != "0")
                {
                    sql += " AND sp.MaDanhMuc = @MaDanhMuc";
                    cmd.Parameters.AddWithValue("@MaDanhMuc", ddlLocDanhMuc.SelectedValue);
                }

                if (ddlLocThuongHieu.SelectedIndex > 0 && ddlLocThuongHieu.SelectedValue != "0")
                {
                    sql += " AND sp.MaThuongHieu = @MaThuongHieu";
                    cmd.Parameters.AddWithValue("@MaThuongHieu", ddlLocThuongHieu.SelectedValue);
                }

                if (ddlLocTrangThai.SelectedValue != "-1")
                {
                    sql += " AND sp.TrangThai = @TrangThai";
                    cmd.Parameters.AddWithValue("@TrangThai", ddlLocTrangThai.SelectedValue);
                }

                sql += " ORDER BY sp.MaSanPham DESC";
                cmd.CommandText = sql;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvSanPham.DataSource = dt;
                gvSanPham.DataBind();
            }
        }

        protected void btnMoFormThem_Click(object sender, EventArgs e)
        {
            XoaTrangForm();
            lblTieuDeForm.Text = "THÊM LAPTOP MỚI";
            pnlFormSanPham.Visible = true;
            pnlThongBao.Visible = false;
        }

        protected void btnHuyForm_Click(object sender, EventArgs e)
        {
            pnlFormSanPham.Visible = false;
            XoaTrangForm();
        }

        // Reset các ô nhập về mặc định
        private void XoaTrangForm()
        {
            hfMaSanPham.Value = "";
            hfAnhDaiDienCu.Value = "";
            txtTenSanPham.Text = "";
            txtGiaGoc.Text = "";
            txtGiaKhuyenMai.Text = "";
            txtSoLuongTon.Text = "10";
            txtMoTa.Text = "";
            ddlTrangThai.SelectedValue = "1";

            txtCPU.Text = "";
            txtRAM.Text = "";
            txtOCung.Text = "";
            txtCardDoHoa.Text = "";
            txtManHinh.Text = "";
            txtDoPhanGiai.Text = "";
            txtTanSoQuet.Text = "";
            txtHeDieuHanh.Text = "";
            txtTrongLuong.Text = "";
            txtPin.Text = "";
            txtMauSac.Text = "";

            imgPreview.ImageUrl = "~/Images/no-image.png";
            rptAlbumAnh.DataSource = null;
            rptAlbumAnh.DataBind();
        }

        protected void btnLuuSanPham_Click(object sender, EventArgs e)
        {
            Page.Validate("vgSanPham");
            if (!Page.IsValid) return;

            string anhDaiDien = string.IsNullOrEmpty(hfAnhDaiDienCu.Value) ? "no-image.png" : hfAnhDaiDienCu.Value;

            // Upload ảnh đại diện nếu có chọn file mới
            if (fuAnhDaiDien.HasFile)
            {
                string ext = Path.GetExtension(fuAnhDaiDien.FileName).ToLower();
                anhDaiDien = "sp_" + DateTime.Now.Ticks + ext;
                fuAnhDaiDien.SaveAs(Server.MapPath("~/Images/" + anhDaiDien));
            }

            object giaKMValue = string.IsNullOrWhiteSpace(txtGiaKhuyenMai.Text)
                                ? (object)DBNull.Value
                                : Convert.ToDecimal(txtGiaKhuyenMai.Text.Trim());

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                int maSanPham = 0;

                // Nếu chưa có mã sp thì thêm mới, ngược lại thì cập nhật
                if (string.IsNullOrEmpty(hfMaSanPham.Value))
                {
                    string sqlSP = @"INSERT INTO tblSanPham 
                                     (TenSanPham, MaDanhMuc, MaThuongHieu, GiaGoc, GiaKhuyenMai, SoLuongTon, MoTa, AnhDaiDien, TrangThai)
                                     VALUES 
                                     (@TenSanPham, @MaDanhMuc, @MaThuongHieu, @GiaGoc, @GiaKhuyenMai, @SoLuongTon, @MoTa, @AnhDaiDien, @TrangThai);
                                     SELECT SCOPE_IDENTITY();";

                    SqlCommand cmdSP = new SqlCommand(sqlSP, conn);
                    cmdSP.Parameters.AddWithValue("@TenSanPham", txtTenSanPham.Text.Trim());
                    cmdSP.Parameters.AddWithValue("@MaDanhMuc", ddlDanhMuc.SelectedValue);
                    cmdSP.Parameters.AddWithValue("@MaThuongHieu", ddlThuongHieu.SelectedValue);
                    cmdSP.Parameters.AddWithValue("@GiaGoc", Convert.ToDecimal(txtGiaGoc.Text.Trim()));
                    cmdSP.Parameters.AddWithValue("@GiaKhuyenMai", giaKMValue);
                    cmdSP.Parameters.AddWithValue("@SoLuongTon", Convert.ToInt32(txtSoLuongTon.Text.Trim()));
                    cmdSP.Parameters.AddWithValue("@MoTa", txtMoTa.Text.Trim());
                    cmdSP.Parameters.AddWithValue("@AnhDaiDien", anhDaiDien);
                    cmdSP.Parameters.AddWithValue("@TrangThai", Convert.ToInt32(ddlTrangThai.SelectedValue));

                    // Lấy mã sản phẩm vừa thêm để lưu tiếp bảng thông số và hình ảnh
                    maSanPham = Convert.ToInt32(cmdSP.ExecuteScalar());

                    string sqlTS = @"INSERT INTO tblThongSoKyThuat 
                                     (MaSanPham, CPU, RAM, OCung, CardDoHoa, ManHinh, DoPhanGiai, TanSoQuet, HeDieuHanh, TrongLuong, Pin, MauSac)
                                     VALUES 
                                     (@MaSanPham, @CPU, @RAM, @OCung, @CardDoHoa, @ManHinh, @DoPhanGiai, @TanSoQuet, @HeDieuHanh, @TrongLuong, @Pin, @MauSac)";
                    SqlCommand cmdTS = new SqlCommand(sqlTS, conn);
                    GanThamSoThongSo(cmdTS, maSanPham);
                    cmdTS.ExecuteNonQuery();
                }
                else
                {
                    maSanPham = Convert.ToInt32(hfMaSanPham.Value);
                    string sqlSP = @"UPDATE tblSanPham 
                                     SET TenSanPham = @TenSanPham, MaDanhMuc = @MaDanhMuc, MaThuongHieu = @MaThuongHieu,
                                         GiaGoc = @GiaGoc, GiaKhuyenMai = @GiaKhuyenMai, SoLuongTon = @SoLuongTon,
                                         MoTa = @MoTa, AnhDaiDien = @AnhDaiDien, TrangThai = @TrangThai
                                     WHERE MaSanPham = @MaSanPham";

                    SqlCommand cmdSP = new SqlCommand(sqlSP, conn);
                    cmdSP.Parameters.AddWithValue("@TenSanPham", txtTenSanPham.Text.Trim());
                    cmdSP.Parameters.AddWithValue("@MaDanhMuc", ddlDanhMuc.SelectedValue);
                    cmdSP.Parameters.AddWithValue("@MaThuongHieu", ddlThuongHieu.SelectedValue);
                    cmdSP.Parameters.AddWithValue("@GiaGoc", Convert.ToDecimal(txtGiaGoc.Text.Trim()));
                    cmdSP.Parameters.AddWithValue("@GiaKhuyenMai", giaKMValue);
                    cmdSP.Parameters.AddWithValue("@SoLuongTon", Convert.ToInt32(txtSoLuongTon.Text.Trim()));
                    cmdSP.Parameters.AddWithValue("@MoTa", txtMoTa.Text.Trim());
                    cmdSP.Parameters.AddWithValue("@AnhDaiDien", anhDaiDien);
                    cmdSP.Parameters.AddWithValue("@TrangThai", Convert.ToInt32(ddlTrangThai.SelectedValue));
                    cmdSP.Parameters.AddWithValue("@MaSanPham", maSanPham);
                    cmdSP.ExecuteNonQuery();

                    // Cập nhật thông số, nếu sp cũ chưa có thông số thì insert mới
                    string sqlTS = @"IF EXISTS (SELECT 1 FROM tblThongSoKyThuat WHERE MaSanPham = @MaSanPham)
                                        UPDATE tblThongSoKyThuat 
                                        SET CPU=@CPU, RAM=@RAM, OCung=@OCung, CardDoHoa=@CardDoHoa, ManHinh=@ManHinh, 
                                            DoPhanGiai=@DoPhanGiai, TanSoQuet=@TanSoQuet, HeDieuHanh=@HeDieuHanh, 
                                            TrongLuong=@TrongLuong, Pin=@Pin, MauSac=@MauSac
                                        WHERE MaSanPham = @MaSanPham
                                     ELSE
                                        INSERT INTO tblThongSoKyThuat 
                                        (MaSanPham, CPU, RAM, OCung, CardDoHoa, ManHinh, DoPhanGiai, TanSoQuet, HeDieuHanh, TrongLuong, Pin, MauSac)
                                        VALUES (@MaSanPham, @CPU, @RAM, @OCung, @CardDoHoa, @ManHinh, @DoPhanGiai, @TanSoQuet, @HeDieuHanh, @TrongLuong, @Pin, @MauSac)";
                    SqlCommand cmdTS = new SqlCommand(sqlTS, conn);
                    GanThamSoThongSo(cmdTS, maSanPham);
                    cmdTS.ExecuteNonQuery();
                }

                // Lưu danh sách ảnh phụ nếu có chọn
                if (fuAlbumAnh.HasFiles)
                {
                    int index = 0;
                    foreach (HttpPostedFile file in fuAlbumAnh.PostedFiles)
                    {
                        string ext = Path.GetExtension(file.FileName).ToLower();
                        if (ext == ".jpg" || ext == ".jpeg" || ext == ".png" || ext == ".webp")
                        {
                            index++;
                            string subImgName = "album_" + maSanPham + "_" + DateTime.Now.Ticks + "_" + index + ext;
                            file.SaveAs(Server.MapPath("~/Images/" + subImgName));

                            string sqlImg = "INSERT INTO tblHinhAnhSanPham (MaSanPham, DuongDanAnh, LaAnhChinh) VALUES (@MaSanPham, @DuongDanAnh, 0)";
                            SqlCommand cmdImg = new SqlCommand(sqlImg, conn);
                            cmdImg.Parameters.AddWithValue("@MaSanPham", maSanPham);
                            cmdImg.Parameters.AddWithValue("@DuongDanAnh", subImgName);
                            cmdImg.ExecuteNonQuery();
                        }
                    }
                }
            }

            pnlFormSanPham.Visible = false;
            LoadDanhSachSanPham();
            HienThiThongBao("Đã lưu thông tin sản phẩm thành công!", true);
        }

        private void GanThamSoThongSo(SqlCommand cmd, int maSanPham)
        {
            cmd.Parameters.AddWithValue("@MaSanPham", maSanPham);
            cmd.Parameters.AddWithValue("@CPU", txtCPU.Text.Trim());
            cmd.Parameters.AddWithValue("@RAM", txtRAM.Text.Trim());
            cmd.Parameters.AddWithValue("@OCung", txtOCung.Text.Trim());
            cmd.Parameters.AddWithValue("@CardDoHoa", txtCardDoHoa.Text.Trim());
            cmd.Parameters.AddWithValue("@ManHinh", txtManHinh.Text.Trim());
            cmd.Parameters.AddWithValue("@DoPhanGiai", txtDoPhanGiai.Text.Trim());
            cmd.Parameters.AddWithValue("@TanSoQuet", txtTanSoQuet.Text.Trim());
            cmd.Parameters.AddWithValue("@HeDieuHanh", txtHeDieuHanh.Text.Trim());
            cmd.Parameters.AddWithValue("@TrongLuong", txtTrongLuong.Text.Trim());
            cmd.Parameters.AddWithValue("@Pin", txtPin.Text.Trim());
            cmd.Parameters.AddWithValue("@MauSac", txtMauSac.Text.Trim());
        }

        // Xử lý sự kiện bấm nút Sửa / Xóa trên GridView
        protected void gvSanPham_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int maSP = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "SuaSP")
            {
                XoaTrangForm();
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    string sql = @"SELECT sp.*, ts.CPU, ts.RAM, ts.OCung, ts.CardDoHoa, ts.ManHinh, 
                                          ts.DoPhanGiai, ts.TanSoQuet, ts.HeDieuHanh, ts.TrongLuong, ts.Pin, ts.MauSac
                                   FROM tblSanPham sp
                                   LEFT JOIN tblThongSoKyThuat ts ON sp.MaSanPham = ts.MaSanPham
                                   WHERE sp.MaSanPham = @MaSanPham";

                    SqlCommand cmd = new SqlCommand(sql, conn);
                    cmd.Parameters.AddWithValue("@MaSanPham", maSP);
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        hfMaSanPham.Value = reader["MaSanPham"].ToString();
                        txtTenSanPham.Text = reader["TenSanPham"].ToString();
                        if (reader["MaDanhMuc"] != DBNull.Value) ddlDanhMuc.SelectedValue = reader["MaDanhMuc"].ToString();
                        if (reader["MaThuongHieu"] != DBNull.Value) ddlThuongHieu.SelectedValue = reader["MaThuongHieu"].ToString();

                        txtGiaGoc.Text = Convert.ToDecimal(reader["GiaGoc"]).ToString("0");
                        txtGiaKhuyenMai.Text = reader["GiaKhuyenMai"] != DBNull.Value ? Convert.ToDecimal(reader["GiaKhuyenMai"]).ToString("0") : "";
                        txtSoLuongTon.Text = reader["SoLuongTon"].ToString();
                        txtMoTa.Text = reader["MoTa"] != DBNull.Value ? reader["MoTa"].ToString() : "";
                        ddlTrangThai.SelectedValue = reader["TrangThai"].ToString();

                        string anh = reader["AnhDaiDien"] != DBNull.Value ? reader["AnhDaiDien"].ToString() : "no-image.png";
                        hfAnhDaiDienCu.Value = anh;
                        imgPreview.ImageUrl = string.IsNullOrEmpty(anh) ? "" : anh;

                        txtCPU.Text = reader["CPU"].ToString();
                        txtRAM.Text = reader["RAM"].ToString();
                        txtOCung.Text = reader["OCung"].ToString();
                        txtCardDoHoa.Text = reader["CardDoHoa"].ToString();
                        txtManHinh.Text = reader["ManHinh"].ToString();
                        txtDoPhanGiai.Text = reader["DoPhanGiai"].ToString();
                        txtTanSoQuet.Text = reader["TanSoQuet"].ToString();
                        txtHeDieuHanh.Text = reader["HeDieuHanh"].ToString();
                        txtTrongLuong.Text = reader["TrongLuong"].ToString();
                        txtPin.Text = reader["Pin"].ToString();
                        txtMauSac.Text = reader["MauSac"].ToString();
                    }
                    reader.Close();

                    LoadAlbumAnhPhu(maSP, conn);
                }

                lblTieuDeForm.Text = "CẬP NHẬT LAPTOP (Mã SP: #" + maSP + ")";
                pnlFormSanPham.Visible = true;
                pnlThongBao.Visible = false;
            }
            else if (e.CommandName == "XoaSP")
            {
                try
                {
                    using (SqlConnection conn = new SqlConnection(connStr))
                    {
                        SqlCommand cmd = new SqlCommand("DELETE FROM tblSanPham WHERE MaSanPham = @MaSanPham", conn);
                        cmd.Parameters.AddWithValue("@MaSanPham", maSP);
                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                    LoadDanhSachSanPham();
                    HienThiThongBao("Đã xóa sản phẩm thành công!", true);
                }
                catch
                {
                    // Bắt lỗi khóa ngoại nếu sản phẩm đã nằm trong chi tiết đơn hàng
                    HienThiThongBao("Sản phẩm này đã phát sinh đơn hàng nên không thể xóa! Hãy chuyển trạng thái sang 'Ngừng kinh doanh'.", false);
                }
            }
        }

        private void LoadAlbumAnhPhu(int maSP, SqlConnection conn)
        {
            SqlDataAdapter da = new SqlDataAdapter("SELECT MaHinhAnh, DuongDanAnh FROM tblHinhAnhSanPham WHERE MaSanPham = " + maSP, conn);
            DataTable dt = new DataTable();
            da.Fill(dt);
            rptAlbumAnh.DataSource = dt;
            rptAlbumAnh.DataBind();
        }

        // Xóa ảnh phụ trong album
        protected void rptAlbumAnh_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "XoaAnh")
            {
                int maHinhAnh = Convert.ToInt32(e.CommandArgument);
                int maSP = Convert.ToInt32(hfMaSanPham.Value);

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("DELETE FROM tblHinhAnhSanPham WHERE MaHinhAnh = @MaHinhAnh", conn);
                    cmd.Parameters.AddWithValue("@MaHinhAnh", maHinhAnh);
                    cmd.ExecuteNonQuery();

                    LoadAlbumAnhPhu(maSP, conn);
                }
            }
        }

        protected void gvSanPham_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvSanPham.PageIndex = e.NewPageIndex;
            LoadDanhSachSanPham();
        }

        protected void BoLoc_Changed(object sender, EventArgs e)
        {
            gvSanPham.PageIndex = 0;
            LoadDanhSachSanPham();
        }
    }
}