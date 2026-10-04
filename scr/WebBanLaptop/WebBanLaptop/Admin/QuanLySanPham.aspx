<%@ Page Title="Quản lý Laptop" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="QuanLySanPham.aspx.cs" Inherits="WebBanLaptop.Admin.QuanLySanPham" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Hiển thị thông báo -->
    <asp:Panel ID="pnlThongBao" runat="server" Visible="false" CssClass="alert rounded-3 py-2 small mb-3 shadow-sm">
        <asp:Label ID="lblThongBao" runat="server"></asp:Label>
    </asp:Panel>

    <!-- Header & nút thêm mới -->
    <div class="d-flex flex-column flex-sm-row justify-content-between align-items-sm-center mb-3 gap-2 bg-white p-3 px-4 rounded-4 shadow-sm">
        <div>
            <h5 class="fw-bold text-dark mb-0">
                <i class="bi bi-pc-display text-danger me-2"></i>QUẢN LÝ SẢN PHẨM LAPTOP
            </h5>
            <small class="text-secondary">Quản lý thông tin máy, cấu hình kỹ thuật và thư viện hình ảnh</small>
        </div>

        <asp:LinkButton ID="btnMoFormThem" runat="server"
            CssClass="btn btn-danger fw-bold rounded-3 px-3 py-2 shadow-sm"
            CausesValidation="false"
            OnClick="btnMoFormThem_Click">
            <i class="bi bi-plus-lg me-1"></i> Thêm Laptop mới
        </asp:LinkButton>
    </div>

    <!-- Form thêm / sửa sản phẩm -->
    <asp:Panel ID="pnlFormSanPham" runat="server" Visible="false" CssClass="card border-0 shadow-sm rounded-4 mb-4 overflow-hidden">
        <div class="card-header bg-danger text-white p-3 px-4 d-flex justify-content-between align-items-center">
            <h6 class="fw-bold mb-0">
                <i class="bi bi-laptop me-2"></i>
                <asp:Label ID="lblTieuDeForm" runat="server" Text="THÊM LAPTOP MỚI"></asp:Label>
            </h6>
            <asp:LinkButton ID="btnDongForm" runat="server" CssClass="btn-close btn-close-white" CausesValidation="false" OnClick="btnHuyForm_Click"></asp:LinkButton>
        </div>

        <div class="card-body p-4 bg-white">
            <!-- Lưu lại mã sp và ảnh cũ khi sửa -->
            <asp:HiddenField ID="hfMaSanPham" runat="server" Value="" />
            <asp:HiddenField ID="hfAnhDaiDienCu" runat="server" Value="" />

            <!-- Chia tab nhập liệu -->
            <ul class="nav nav-tabs mb-4 fw-semibold" id="productTab" role="tablist">
                <li class="nav-item" role="presentation">
                    <button class="nav-link active text-danger" id="info-tab" data-bs-toggle="tab" data-bs-target="#tabThongTin" type="button" role="tab">
                        <i class="bi bi-info-circle me-1"></i>Thông tin chung
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link text-dark" id="spec-tab" data-bs-toggle="tab" data-bs-target="#tabThongSo" type="button" role="tab">
                        <i class="bi bi-cpu me-1"></i>Cấu hình kỹ thuật
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link text-dark" id="img-tab" data-bs-toggle="tab" data-bs-target="#tabHinhAnh" type="button" role="tab">
                        <i class="bi bi-images me-1"></i>Hình ảnh sản phẩm
                    </button>
                </li>
            </ul>

            <div class="tab-content" id="productTabContent">

                <!-- Tab thông tin cơ bản -->
                <div class="tab-pane fade show active" id="tabThongTin" role="tabpanel">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label fw-semibold small">Tên Laptop <span class="text-danger">*</span></label>
                            <asp:TextBox ID="txtTenSanPham" runat="server" MaxLength="200" CssClass="form-control" placeholder="VD: Laptop ASUS TUF Gaming F15 FX507ZC4"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvTenSanPham" runat="server"
                                ControlToValidate="txtTenSanPham" ValidationGroup="vgSanPham"
                                ErrorMessage="Vui lòng nhập tên sản phẩm!"
                                CssClass="text-danger small mt-1" Display="Dynamic" />
                        </div>

                        <div class="col-md-3">
                            <label class="form-label fw-semibold small">Danh mục <span class="text-danger">*</span></label>
                            <asp:DropDownList ID="ddlDanhMuc" runat="server" CssClass="form-select"></asp:DropDownList>
                        </div>

                        <div class="col-md-3">
                            <label class="form-label fw-semibold small">Thương hiệu <span class="text-danger">*</span></label>
                            <asp:DropDownList ID="ddlThuongHieu" runat="server" CssClass="form-select"></asp:DropDownList>
                        </div>

                        <div class="col-md-3">
                            <label class="form-label fw-semibold small">Giá gốc (VNĐ) <span class="text-danger">*</span></label>
                            <asp:TextBox ID="txtGiaGoc" runat="server" CssClass="form-control" placeholder="VD: 21990000"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvGiaGoc" runat="server"
                                ControlToValidate="txtGiaGoc" ValidationGroup="vgSanPham"
                                ErrorMessage="Vui lòng nhập giá gốc!"
                                CssClass="text-danger small mt-1" Display="Dynamic" />
                            <asp:RegularExpressionValidator ID="revGiaGoc" runat="server"
                                ControlToValidate="txtGiaGoc" ValidationGroup="vgSanPham"
                                ValidationExpression="^\d+$" ErrorMessage="Giá phải là số nguyên!"
                                CssClass="text-danger small mt-1" Display="Dynamic" />
                        </div>

                        <div class="col-md-3">
                            <label class="form-label fw-semibold small">Giá khuyến mãi (VNĐ)</label>
                            <asp:TextBox ID="txtGiaKhuyenMai" runat="server" CssClass="form-control" placeholder="Bỏ trống nếu không giảm"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="revGiaKM" runat="server"
                                ControlToValidate="txtGiaKhuyenMai" ValidationGroup="vgSanPham"
                                ValidationExpression="^\d+$" ErrorMessage="Giá KM phải là số nguyên!"
                                CssClass="text-danger small mt-1" Display="Dynamic" />
                        </div>

                        <div class="col-md-3">
                            <label class="form-label fw-semibold small">Số lượng tồn <span class="text-danger">*</span></label>
                            <asp:TextBox ID="txtSoLuongTon" runat="server" TextMode="Number" CssClass="form-control" Text="10"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvSoLuong" runat="server"
                                ControlToValidate="txtSoLuongTon" ValidationGroup="vgSanPham"
                                ErrorMessage="Nhập số lượng tồn!"
                                CssClass="text-danger small mt-1" Display="Dynamic" />
                        </div>

                        <div class="col-md-3">
                            <label class="form-label fw-semibold small">Trạng thái</label>
                            <asp:DropDownList ID="ddlTrangThai" runat="server" CssClass="form-select">
                                <asp:ListItem Value="1" Selected="True">Đang kinh doanh</asp:ListItem>
                                <asp:ListItem Value="0">Ngừng kinh doanh / Ẩn</asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <div class="col-12">
                            <label class="form-label fw-semibold small">Bài viết mô tả sản phẩm</label>
                            <asp:TextBox ID="txtMoTa" runat="server" TextMode="MultiLine" Rows="4" CssClass="form-control" placeholder="Nhập mô tả chi tiết, điểm nổi bật của laptop..."></asp:TextBox>
                        </div>
                    </div>
                </div>

                <!-- Tab thông số kỹ thuật -->
                <div class="tab-pane fade" id="tabThongSo" role="tabpanel">
                    <div class="row g-3">
                        <div class="col-md-4">
                            <label class="form-label fw-semibold small">Vi xử lý (CPU)</label>
                            <asp:TextBox ID="txtCPU" runat="server" MaxLength="100" CssClass="form-control" placeholder="VD: Intel Core i5-12500H"></asp:TextBox>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-semibold small">Bộ nhớ RAM</label>
                            <asp:TextBox ID="txtRAM" runat="server" MaxLength="50" CssClass="form-control" placeholder="VD: 16GB DDR4 3200MHz"></asp:TextBox>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-semibold small">Ổ cứng</label>
                            <asp:TextBox ID="txtOCung" runat="server" MaxLength="100" CssClass="form-control" placeholder="VD: 512GB SSD NVMe PCIe"></asp:TextBox>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-semibold small">Card đồ họa (VGA)</label>
                            <asp:TextBox ID="txtCardDoHoa" runat="server" MaxLength="100" CssClass="form-control" placeholder="VD: NVIDIA GeForce RTX 3050 4GB"></asp:TextBox>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-semibold small">Kích thước màn hình</label>
                            <asp:TextBox ID="txtManHinh" runat="server" MaxLength="100" CssClass="form-control" placeholder="VD: 15.6 inch IPS"></asp:TextBox>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-semibold small">Độ phân giải</label>
                            <asp:TextBox ID="txtDoPhanGiai" runat="server" MaxLength="50" CssClass="form-control" placeholder="VD: Full HD (1920 x 1080)"></asp:TextBox>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label fw-semibold small">Tần số quét</label>
                            <asp:TextBox ID="txtTanSoQuet" runat="server" MaxLength="50" CssClass="form-control" placeholder="VD: 144Hz"></asp:TextBox>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label fw-semibold small">Hệ điều hành</label>
                            <asp:TextBox ID="txtHeDieuHanh" runat="server" MaxLength="50" CssClass="form-control" placeholder="VD: Windows 11 Home"></asp:TextBox>
                        </div>
                        <div class="col-md-2">
                            <label class="form-label fw-semibold small">Trọng lượng</label>
                            <asp:TextBox ID="txtTrongLuong" runat="server" MaxLength="50" CssClass="form-control" placeholder="VD: 2.2 kg"></asp:TextBox>
                        </div>
                        <div class="col-md-2">
                            <label class="form-label fw-semibold small">Pin</label>
                            <asp:TextBox ID="txtPin" runat="server" MaxLength="50" CssClass="form-control" placeholder="VD: 4 Cell 56WHrs"></asp:TextBox>
                        </div>
                        <div class="col-md-2">
                            <label class="form-label fw-semibold small">Màu sắc</label>
                            <asp:TextBox ID="txtMauSac" runat="server" MaxLength="50" CssClass="form-control" placeholder="VD: Xám (Mecha Gray)"></asp:TextBox>
                        </div>
                    </div>
                </div>

                <!-- Tab hình ảnh -->
                <div class="tab-pane fade" id="tabHinhAnh" role="tabpanel">
                    <div class="row g-4">
                        <div class="col-md-5">
                            <div class="border rounded-4 p-3 bg-light text-center h-100">
                                <label class="form-label fw-bold small text-danger d-block">Ảnh đại diện chính</label>
                                <asp:Image ID="imgPreview" runat="server" ImageUrl="~/Images/no-image.png"
                                    CssClass="img-fluid rounded-3 border bg-white p-2 mb-3 object-fit-contain"
                                    Style="height: 150px; width: 100%;" />
                                <asp:FileUpload ID="fuAnhDaiDien" runat="server" CssClass="form-control form-control-sm" accept=".jpg,.jpeg,.png,.webp" onchange="xemTruocAnh(this);" />
                                <small class="text-muted d-block mt-1">Ảnh hiển thị ngoài danh sách sản phẩm</small>
                            </div>
                        </div>

                        <div class="col-md-7">
                            <div class="border rounded-4 p-3 bg-light h-100">
                                <label class="form-label fw-bold small text-dark d-block">Album ảnh chi tiết</label>
                                <p class="text-secondary small mb-2">Giữ phím <strong>Ctrl</strong> để chọn nhiều ảnh cùng lúc:</p>
                                <asp:FileUpload ID="fuAlbumAnh" runat="server" AllowMultiple="true" CssClass="form-control form-control-sm mb-3" accept=".jpg,.jpeg,.png,.webp" />

                                <!-- Danh sách ảnh phụ khi sửa -->
                                <div class="d-flex flex-wrap gap-2">
                                    <asp:Repeater ID="rptAlbumAnh" runat="server" OnItemCommand="rptAlbumAnh_ItemCommand">
                                        <ItemTemplate>
                                            <div class="position-relative border rounded-3 bg-white p-1" style="width: 80px; height: 70px;">
                                                <img src='<%# Eval("DuongDanAnh", "/Images/Sanpham/{0}") %>' onerror="this.onerror=null; this.src='/Images/no-image.png';" class="w-100 h-100 object-fit-contain" />
                                                <asp:LinkButton ID="btnXoaAnhPhu" runat="server"
                                                    CommandName="XoaAnh" CommandArgument='<%# Eval("MaHinhAnh") %>'
                                                    CausesValidation="false"
                                                    CssClass="position-absolute top-0 end-0 badge bg-danger text-white border-0 text-decoration-none"
                                                    ToolTip="Xóa ảnh này">×</asp:LinkButton>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

            <div class="mt-4 pt-3 border-top d-flex justify-content-end gap-2">
                <asp:Button ID="btnHuy" runat="server" Text="Hủy bỏ" CausesValidation="false"
                    CssClass="btn btn-light border px-4 rounded-3" OnClick="btnHuyForm_Click" />
                <asp:Button ID="btnLuuSanPham" runat="server" Text="LƯU SẢN PHẨM" ValidationGroup="vgSanPham"
                    CssClass="btn btn-danger fw-bold px-4 rounded-3 shadow-sm" OnClick="btnLuuSanPham_Click" />
            </div>
        </div>
    </asp:Panel>

    <!-- Khung tìm kiếm & lọc -->
    <div class="card border-0 shadow-sm rounded-4 mb-4">
        <div class="card-body p-3">
            <div class="row g-2 align-items-center">
                <div class="col-12 col-lg-4">
                    <div class="input-group">
                        <span class="input-group-text bg-light border-end-0"><i class="bi bi-search text-secondary"></i></span>
                        <asp:TextBox ID="txtTimKiem" runat="server" CssClass="form-control border-start-0" placeholder="Tìm theo tên laptop, CPU..."></asp:TextBox>
                        <asp:Button ID="btnTimKiem" runat="server" Text="Tìm" CausesValidation="false" CssClass="btn btn-danger px-3" OnClick="BoLoc_Changed" />
                    </div>
                </div>

                <div class="col-6 col-lg-3">
                    <asp:DropDownList ID="ddlLocDanhMuc" runat="server" AutoPostBack="true" CssClass="form-select" OnSelectedIndexChanged="BoLoc_Changed"></asp:DropDownList>
                </div>

                <div class="col-6 col-lg-3">
                    <asp:DropDownList ID="ddlLocThuongHieu" runat="server" AutoPostBack="true" CssClass="form-select" OnSelectedIndexChanged="BoLoc_Changed"></asp:DropDownList>
                </div>

                <div class="col-12 col-lg-2">
                    <asp:DropDownList ID="ddlLocTrangThai" runat="server" AutoPostBack="true" CssClass="form-select" OnSelectedIndexChanged="BoLoc_Changed">
                        <asp:ListItem Value="-1">-- Trạng thái --</asp:ListItem>
                        <asp:ListItem Value="1">Đang bán</asp:ListItem>
                        <asp:ListItem Value="0">Đã ẩn</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
        </div>
    </div>

    <!-- Bảng danh sách sản phẩm -->
    <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
        <div class="card-body p-0">
            <div class="table-responsive">
                <asp:GridView ID="gvSanPham" runat="server"
                    AutoGenerateColumns="False"
                    DataKeyNames="MaSanPham"
                    AllowPaging="True" PageSize="8"
                    OnPageIndexChanging="gvSanPham_PageIndexChanging"
                    OnRowCommand="gvSanPham_RowCommand"
                    CssClass="table table-hover align-middle mb-0 small"
                    GridLines="None"
                    EmptyDataText="Chưa có sản phẩm nào phù hợp.">
                    <HeaderStyle CssClass="bg-light text-secondary fw-semibold border-bottom" />
                    <Columns>
                        <asp:BoundField DataField="MaSanPham" HeaderText="Mã SP" ItemStyle-CssClass="fw-bold ps-4 text-secondary" HeaderStyle-CssClass="ps-4 py-3" />

                        <asp:TemplateField HeaderText="Ảnh" HeaderStyle-CssClass="py-3">
                            <ItemTemplate>
                                <img src='<%# Eval("AnhDaiDien", "/Images/Sanpham/{0}") %>' alt="Laptop"
                                    class="rounded-3 border bg-white p-1 object-fit-contain" style="width: 65px; height: 50px;" />
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Tên Laptop & Cấu hình" HeaderStyle-CssClass="py-3">
                            <ItemTemplate>
                                <div class="fw-bold text-dark"><%# Eval("TenSanPham") %></div>
                                <div class="text-secondary" style="font-size: 0.78rem;">
                                    <i class="bi bi-cpu"></i><%# Eval("CPU") %> | <%# Eval("RAM") %> | <%# Eval("OCung") %> | <%# Eval("CardDoHoa") %>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Phân loại" HeaderStyle-CssClass="py-3">
                            <ItemTemplate>
                                <span class="badge bg-danger bg-opacity-10 text-danger border border-danger border-opacity-25 me-1"><%# Eval("TenThuongHieu") %></span>
                                <span class="badge bg-light text-secondary border"><%# Eval("TenDanhMuc") %></span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Giá bán" HeaderStyle-CssClass="py-3">
                            <ItemTemplate>
                                <%# Eval("GiaKhuyenMai") != DBNull.Value && Convert.ToDecimal(Eval("GiaKhuyenMai")) > 0 
                                    ? "<div class='fw-bold text-danger'>" + Convert.ToDecimal(Eval("GiaKhuyenMai")).ToString("N0") + " đ</div><del class='text-muted' style='font-size:0.75rem;'>" + Convert.ToDecimal(Eval("GiaGoc")).ToString("N0") + " đ</del>"
                                    : "<div class='fw-bold text-danger'>" + Convert.ToDecimal(Eval("GiaGoc")).ToString("N0") + " đ</div>" %>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Tồn kho" HeaderStyle-CssClass="py-3">
                            <ItemTemplate>
                                <span class='fw-bold <%# Convert.ToInt32(Eval("SoLuongTon")) > 0 ? "text-dark" : "text-danger" %>'>
                                    <%# Eval("SoLuongTon") %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Trạng thái" HeaderStyle-CssClass="py-3">
                            <ItemTemplate>
                                <span class='badge rounded-pill <%# Convert.ToInt32(Eval("TrangThai")) == 1 ? "bg-success" : "bg-secondary" %>'>
                                    <%# Convert.ToInt32(Eval("TrangThai")) == 1 ? "Đang bán" : "Đã ẩn" %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Thao tác" HeaderStyle-CssClass="text-end pe-4 py-3" ItemStyle-CssClass="text-end pe-4 text-nowrap">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnSua" runat="server" CommandName="SuaSP" CommandArgument='<%# Eval("MaSanPham") %>'
                                    CausesValidation="false" CssClass="btn btn-sm btn-outline-primary rounded-3 me-1">
                                    <i class="bi bi-pencil-square"></i> Sửa
                                </asp:LinkButton>

                                <asp:LinkButton ID="btnXoa" runat="server" CommandName="XoaSP" CommandArgument='<%# Eval("MaSanPham") %>'
                                    CausesValidation="false" OnClientClick="return confirm('Xóa sản phẩm sẽ xóa luôn cấu hình và ảnh đi kèm. Bạn chắc chắn muốn xóa?');"
                                    CssClass="btn btn-sm btn-outline-danger rounded-3">
                                    <i class="bi bi-trash3"></i>
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <PagerStyle CssClass="p-3 bg-light border-top" HorizontalAlign="Right" />
                </asp:GridView>
            </div>
        </div>
    </div>

    <script>
        // Xem trước ảnh đại diện khi chọn file
        function xemTruocAnh(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    document.getElementById('<%= imgPreview.ClientID %>').src = e.target.result;
                };
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>
</asp:Content>
