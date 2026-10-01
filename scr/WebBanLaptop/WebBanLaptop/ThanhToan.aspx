<%@ Page Title="Thanh toán" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ThanhToan.aspx.cs" Inherits="WebBanLaptop.ThanhToan" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container my-5" style="max-width: 650px;">
        
        <!-- Panel 1: Form nhập thông tin đặt hàng -->
        <asp:Panel ID="pnlFormDatHang" runat="server" CssClass="card shadow-sm">
            <div class="card-header bg-primary text-white">
                <h4 class="mb-0">Thông Tin Đặt Hàng</h4>
            </div>
            <div class="card-body p-4">
                <div class="mb-3">
                    <label class="form-label fw-semibold">Họ và tên người nhận</label>
                    <asp:TextBox ID="txtHoTen" runat="server" CssClass="form-control" placeholder="Nhập họ tên..."></asp:TextBox>
                </div>
                <div class="mb-3">
                    <label class="form-label fw-semibold">Số điện thoại</label>
                    <asp:TextBox ID="txtSoDienThoai" runat="server" CssClass="form-control" placeholder="Nhập số điện thoại..."></asp:TextBox>
                </div>
                <div class="mb-3">
                    <label class="form-label fw-semibold">Địa chỉ giao hàng</label>
                    <asp:TextBox ID="txtDiaChi" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2" placeholder="Số nhà, đường, phường/xã..."></asp:TextBox>
                </div>
                <div class="mb-3">
                    <label class="form-label fw-semibold">Phương thức thanh toán</label>
                    <asp:DropDownList ID="ddlPhuongThuc" runat="server" CssClass="form-select">
                        <asp:ListItem Value="COD">Thanh toán khi nhận hàng (COD)</asp:ListItem>
                        <asp:ListItem Value="Banking">Chuyển khoản ngân hàng</asp:ListItem>
                    </asp:DropDownList>
                </div>

                <hr />
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <span class="fs-5 fw-semibold">Tổng tiền cần thanh toán:</span>
                    <asp:Label ID="lblTongThanhToan" runat="server" CssClass="fs-4 fw-bold text-danger" Text="0 đ"></asp:Label>
                </div>

                <asp:Button ID="btnDatHang" runat="server" Text="Xác Nhận Đặt Hàng" 
                    CssClass="btn btn-success btn-lg w-100" OnClick="btnDatHang_Click" />
            </div>
        </asp:Panel>

        <!-- Panel 2: Thông báo đặt hàng thành công (Mặc định ẩn, nhấn nút mới hiện) -->
        <asp:Panel ID="pnlThanhCong" runat="server" Visible="false" CssClass="card border-success shadow-sm text-center p-5">
            <div class="mb-3" style="font-size: 3.5rem;">🎉</div>
            <h3 class="text-success fw-bold">Đặt Hàng Thành Công!</h3>
            <p class="text-muted mt-2">
                Cảm ơn bạn đã mua sắm tại cửa hàng. Đơn hàng của bạn đã được ghi nhận và sẽ sớm được giao đến bạn.
            </p>
            <div class="mt-4">
                <a href="TrangChu.aspx" class="btn btn-primary px-4">Về Trang Chủ</a>
            </div>
        </asp:Panel>

    </div>
</asp:Content>