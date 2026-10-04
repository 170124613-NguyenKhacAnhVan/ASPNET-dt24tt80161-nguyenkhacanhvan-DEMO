<%@ Page Title="Quản lý Danh Mục" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="QuanLyDanhMuc.aspx.cs" Inherits="WebBanLaptop.Admin.QuanLyDanhMuc" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Hiển thị thông báo -->
    <asp:Panel ID="pnlThongBao" runat="server" Visible="false" CssClass="alert rounded-3 py-2 small mb-3 shadow-sm">
        <asp:Label ID="lblThongBao" runat="server"></asp:Label>
    </asp:Panel>

    <!-- Header & nút thêm mới -->
    <div class="d-flex flex-column flex-sm-row justify-content-between align-items-sm-center mb-3 gap-2 bg-white p-3 px-4 rounded-4 shadow-sm">
        <div>
            <h5 class="fw-bold text-dark mb-0">
                <i class="bi bi-tags text-primary me-2"></i>QUẢN LÝ DANH MỤC
            </h5>
            <small class="text-secondary">Quản lý các loại sản phẩm trên hệ thống</small>
        </div>

        <asp:LinkButton ID="btnMoFormThem" runat="server"
            CssClass="btn btn-primary fw-bold rounded-3 px-3 py-2 shadow-sm"
            CausesValidation="false"
            OnClick="btnMoFormThem_Click">
            <i class="bi bi-plus-lg me-1"></i> Thêm Danh mục
        </asp:LinkButton>
    </div>

    <!-- Form thêm / sửa -->
    <asp:Panel ID="pnlForm" runat="server" Visible="false" CssClass="card border-0 shadow-sm rounded-4 mb-4 overflow-hidden">
        <div class="card-header bg-primary text-white p-3 px-4 d-flex justify-content-between align-items-center">
            <h6 class="fw-bold mb-0">
                <i class="bi bi-tag-fill me-2"></i>
                <asp:Label ID="lblTieuDeForm" runat="server" Text="THÊM DANH MỤC MỚI"></asp:Label>
            </h6>
            <asp:LinkButton ID="btnDongForm" runat="server" CssClass="btn-close btn-close-white" CausesValidation="false" OnClick="btnHuyForm_Click"></asp:LinkButton>
        </div>

        <div class="card-body p-4 bg-white">
            <asp:HiddenField ID="hfMaDanhMuc" runat="server" Value="" />
            <asp:HiddenField ID="hfHinhAnhCu" runat="server" Value="" />

            <div class="row g-4">
                <!-- Cột nhập thông tin chữ -->
                <div class="col-md-8">
                    <div class="row g-3">
                        <div class="col-md-8">
                            <label class="form-label fw-semibold small">Tên danh mục <span class="text-danger">*</span></label>
                            <asp:TextBox ID="txtTenDanhMuc" runat="server" MaxLength="100" CssClass="form-control" placeholder="VD: Laptop Gaming"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvTenDanhMuc" runat="server"
                                ControlToValidate="txtTenDanhMuc" ValidationGroup="vgForm"
                                ErrorMessage="Vui lòng nhập tên danh mục!"
                                CssClass="text-danger small mt-1" Display="Dynamic" />
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-semibold small">Trạng thái</label>
                            <asp:DropDownList ID="ddlTrangThai" runat="server" CssClass="form-select">
                                <asp:ListItem Value="1" Selected="True">Hiển thị</asp:ListItem>
                                <asp:ListItem Value="0">Đã ẩn</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-12">
                            <label class="form-label fw-semibold small">Mô tả</label>
                            <asp:TextBox ID="txtMoTa" runat="server" TextMode="MultiLine" Rows="4" CssClass="form-control" placeholder="Nhập mô tả ngắn..."></asp:TextBox>
                        </div>
                    </div>
                </div>

                <!-- Cột upload ảnh -->
                <div class="col-md-4">
                    <div class="border rounded-4 p-3 bg-light text-center h-100">
                        <label class="form-label fw-bold small text-primary d-block">Hình ảnh đại diện</label>
                        <asp:Image ID="imgPreview" runat="server" ImageUrl="~/Images/no-image.png"
                            CssClass="img-fluid rounded-3 border bg-white p-2 mb-3 object-fit-contain"
                            Style="height: 140px; width: 100%;" />
                        <asp:FileUpload ID="fuHinhAnh" runat="server" CssClass="form-control form-control-sm" accept=".jpg,.jpeg,.png,.webp" onchange="xemTruocAnh(this);" />
                    </div>
                </div>
            </div>

            <div class="mt-4 pt-3 border-top d-flex justify-content-end gap-2">
                <asp:Button ID="btnHuy" runat="server" Text="Hủy bỏ" CausesValidation="false"
                    CssClass="btn btn-light border px-4 rounded-3" OnClick="btnHuyForm_Click" />
                <asp:Button ID="btnLuu" runat="server" Text="LƯU DỮ LIỆU" ValidationGroup="vgForm"
                    CssClass="btn btn-primary fw-bold px-4 rounded-3 shadow-sm" OnClick="btnLuu_Click" />
            </div>
        </div>
    </asp:Panel>

    <!-- Khung tìm kiếm -->
    <div class="card border-0 shadow-sm rounded-4 mb-4">
        <div class="card-body p-3 d-flex gap-2">
            <div class="input-group" style="max-width: 400px;">
                <span class="input-group-text bg-light border-end-0"><i class="bi bi-search text-secondary"></i></span>
                <asp:TextBox ID="txtTimKiem" runat="server" CssClass="form-control border-start-0" placeholder="Tìm tên danh mục..."></asp:TextBox>
                <asp:Button ID="btnTimKiem" runat="server" Text="Tìm" CausesValidation="false" CssClass="btn btn-primary px-3" OnClick="btnTimKiem_Click" />
            </div>
        </div>
    </div>

    <!-- Bảng danh sách -->
    <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
        <div class="card-body p-0">
            <div class="table-responsive">
                <asp:GridView ID="gvDanhSach" runat="server" AutoGenerateColumns="False"
                    DataKeyNames="MaDanhMuc" AllowPaging="True" PageSize="10"
                    OnPageIndexChanging="gvDanhSach_PageIndexChanging"
                    OnRowCommand="gvDanhSach_RowCommand"
                    CssClass="table table-hover align-middle mb-0 small" GridLines="None"
                    EmptyDataText="Chưa có dữ liệu.">
                    <HeaderStyle CssClass="bg-light text-secondary fw-semibold border-bottom" />
                    <Columns>
                        <asp:BoundField DataField="MaDanhMuc" HeaderText="ID" ItemStyle-CssClass="fw-bold ps-4 text-secondary" HeaderStyle-CssClass="ps-4 py-3" />

                        <asp:TemplateField HeaderText="Hình ảnh" HeaderStyle-CssClass="py-3">
                            <ItemTemplate>
                                <img src='<%# Eval("HinhAnh", "/Images/Danhmuc/{0}") %>' onerror="this.src='/Images/no-image.png'" alt="Img"
                                    class="rounded-3 border bg-white p-1 object-fit-contain" style="width: 60px; height: 60px;" />
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:BoundField DataField="TenDanhMuc" HeaderText="Tên danh mục" ItemStyle-CssClass="fw-bold text-dark" HeaderStyle-CssClass="py-3" />
                        <asp:BoundField DataField="MoTa" HeaderText="Mô tả" ItemStyle-CssClass="text-secondary" HeaderStyle-CssClass="py-3" />

                        <asp:TemplateField HeaderText="Trạng thái" HeaderStyle-CssClass="py-3">
                            <ItemTemplate>
                                <span class='badge rounded-pill <%# Convert.ToInt32(Eval("TrangThai")) == 1 ? "bg-success" : "bg-secondary" %>'>
                                    <%# Convert.ToInt32(Eval("TrangThai")) == 1 ? "Hiển thị" : "Đã ẩn" %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Thao tác" HeaderStyle-CssClass="text-end pe-4 py-3" ItemStyle-CssClass="text-end pe-4 text-nowrap">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnSua" runat="server" CommandName="SuaRecord" CommandArgument='<%# Eval("MaDanhMuc") %>'
                                    CausesValidation="false" CssClass="btn btn-sm btn-outline-primary rounded-3 me-1">
                                    <i class="bi bi-pencil-square"></i> Sửa
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnXoa" runat="server" CommandName="XoaRecord" CommandArgument='<%# Eval("MaDanhMuc") %>'
                                    CausesValidation="false" OnClientClick="return confirm('Bạn chắc chắn muốn xóa danh mục này?');"
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
