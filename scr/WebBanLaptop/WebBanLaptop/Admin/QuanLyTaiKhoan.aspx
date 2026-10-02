<%@ Page Title="Quản lý Tài khoản" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="QuanLyTaiKhoan.aspx.cs" Inherits="WebBanLaptop.Admin.QuanLyTaiKhoan" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="d-flex flex-column flex-sm-row justify-content-between align-items-sm-center mb-4 gap-2 bg-white p-3 px-4 rounded-4 shadow-sm">
        <div>
            <h5 class="fw-bold text-dark mb-0"><i class="bi bi-people-fill text-warning me-2"></i>QUẢN LÝ TÀI KHOẢN</h5>
            <small class="text-secondary">Quản trị viên và khách hàng</small>
        </div>
        <asp:LinkButton ID="btnMoFormThem" runat="server" CssClass="btn btn-warning text-dark fw-bold rounded-3 px-3 py-2 shadow-sm" OnClick="btnMoFormThem_Click">
            <i class="bi bi-plus-lg me-1"></i> Cấp tài khoản mới
        </asp:LinkButton>
    </div>

    <!-- Form Thêm / Sửa Tài khoản -->
    <asp:Panel ID="pnlForm" runat="server" Visible="false" CssClass="card border-0 shadow-sm rounded-4 mb-4">
        <div class="card-header bg-warning text-dark p-3 px-4 d-flex justify-content-between align-items-center">
            <h6 class="fw-bold mb-0">THÔNG TIN TÀI KHOẢN</h6>
            <asp:LinkButton ID="btnDongForm" runat="server" CssClass="btn-close" OnClick="btnHuyForm_Click"></asp:LinkButton>
        </div>
        <div class="card-body p-4 row g-3">
            <asp:HiddenField ID="hfUserID" runat="server" />

            <div class="col-md-4">
                <label class="form-label fw-semibold small">Tên đăng nhập <span class="text-danger">*</span></label>
                <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
            <div class="col-md-4">
                <label class="form-label fw-semibold small">Mật khẩu (Nhập khi tạo mới)</label>
                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
            </div>
            <div class="col-md-4">
                <label class="form-label fw-semibold small">Họ và tên</label>
                <asp:TextBox ID="txtFullname" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
            <div class="col-md-4">
                <label class="form-label fw-semibold small">Số điện thoại</label>
                <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
            <div class="col-md-4">
                <label class="form-label fw-semibold small">Email</label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email"></asp:TextBox>
            </div>
            <div class="col-md-2">
                <label class="form-label fw-semibold small">Quyền hạn</label>
                <asp:DropDownList ID="ddlRole" runat="server" CssClass="form-select">
                    <asp:ListItem Value="0">Khách hàng</asp:ListItem>
                    <asp:ListItem Value="1">Admin</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="col-md-2">
                <label class="form-label fw-semibold small">Trạng thái</label>
                <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-select">
                    <asp:ListItem Value="1">Hoạt động</asp:ListItem>
                    <asp:ListItem Value="0">Khóa</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="col-12 mt-4 text-end">
                <asp:Button ID="btnHuy" runat="server" Text="Hủy" CssClass="btn btn-light border px-4" OnClick="btnHuyForm_Click" />
                <asp:Button ID="btnLuu" runat="server" Text="Lưu Tài Khoản" CssClass="btn btn-warning fw-bold px-4" OnClick="btnLuu_Click" />
            </div>
        </div>
    </asp:Panel>

    <!-- GridView Danh sách -->
    <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
        <asp:GridView ID="gvTaiKhoan" runat="server" AutoGenerateColumns="False" DataKeyNames="UserID"
            CssClass="table table-hover align-middle mb-0 small" GridLines="None" OnRowCommand="gvTaiKhoan_RowCommand">
            <HeaderStyle CssClass="bg-light text-secondary fw-semibold border-bottom" />
            <Columns>
                <asp:BoundField DataField="Username" HeaderText="Tài khoản" ItemStyle-CssClass="fw-bold ps-4" HeaderStyle-CssClass="ps-4 py-3" />
                <asp:BoundField DataField="Fullname" HeaderText="Họ Tên" />
                <asp:BoundField DataField="Phone" HeaderText="SĐT" />
                <asp:BoundField DataField="Email" HeaderText="Email" />
                <asp:TemplateField HeaderText="Vai trò">
                    <ItemTemplate>
                        <span class='badge <%# Convert.ToInt32(Eval("Role")) == 1 ? "bg-danger" : "bg-info text-dark" %>'>
                            <%# Convert.ToInt32(Eval("Role")) == 1 ? "Admin" : "Khách" %>
                        </span>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Trạng thái">
                    <ItemTemplate>
                        <span class='badge rounded-pill <%# Convert.ToInt32(Eval("Status")) == 1 ? "bg-success" : "bg-secondary" %>'>
                            <%# Convert.ToInt32(Eval("Status")) == 1 ? "Hoạt động" : "Đã khóa" %>
                        </span>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Thao tác" ItemStyle-CssClass="text-end pe-4" HeaderStyle-CssClass="text-end pe-4">
                    <ItemTemplate>
                        <asp:LinkButton ID="btnSua" runat="server" CommandName="SuaUser" CommandArgument='<%# Eval("UserID") %>' CssClass="btn btn-sm btn-outline-primary rounded-3">
                            <i class="bi bi-pencil-square"></i> Sửa
                        </asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
