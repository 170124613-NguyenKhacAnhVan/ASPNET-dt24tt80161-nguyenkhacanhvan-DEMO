<%@ Page Title="Thanh toán" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ThanhToan.aspx.cs" Inherits="WebBanLaptop.ThanhToan" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container my-5">

        <!-- Panel 2: Thông báo đặt hàng thành công (Mặc định ẩn) -->
        <asp:Panel ID="pnlThanhCong" runat="server" Visible="false" CssClass="card border-success shadow-sm text-center p-5 mx-auto" Style="max-width: 600px;">
            <div class="mb-3" style="font-size: 3.5rem;">🎉</div>
            <h3 class="text-success fw-bold">Đặt Hàng Thành Công!</h3>
            <p class="text-muted mt-2">
                Cảm ơn bạn đã mua sắm tại cửa hàng. Đơn hàng của bạn đã được ghi nhận và sẽ sớm được giao đến bạn.
            </p>
            <div class="mt-4">
                <a href="Default.aspx" class="btn btn-primary px-4">Về Trang Chủ</a>
            </div>
        </asp:Panel>

        <!-- Panel 1: Bố cục 2 cột cho Form nhập liệu và Thông tin đơn hàng -->
        <asp:Panel ID="pnlFormDatHang" runat="server">
            <div class="row">

                <!-- Cột trái: Form nhập thông tin -->
                <div class="col-md-7 mb-4">
                    <div class="card shadow-sm">
                        <div class="card-header bg-primary text-white">
                            <h5 class="mb-0">Thông Tin Giao Hàng</h5>
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
                        </div>
                    </div>
                </div>

                <!-- Cột phải: Thông tin đơn hàng -->
                <div class="col-md-5">
                    <div class="card shadow-sm border-0 bg-light">
                        <div class="card-body p-4">
                            <h5 class="fw-bold mb-4">Đơn hàng của bạn</h5>

                            <!-- Danh sách sản phẩm dùng Repeater -->
                            <div class="mb-3" style="max-height: 350px; overflow-y: auto; padding-right: 10px;">
                                <asp:Repeater ID="rptDonHang" runat="server">
                                    <ItemTemplate>
                                        <div class="d-flex align-items-center mb-3 pb-3 border-bottom">
                                            <img src='<%# Eval("AnhDaiDien") %>' alt="Laptop" class="img-thumbnail me-3" style="width: 70px; height: 70px; object-fit: cover;" />
                                            <div class="flex-grow-1">
                                                <h6 class="mb-1 text-truncate" style="max-width: 200px;"><%# Eval("TenSanPham") %></h6>
                                                <small class="text-muted">SL: <%# Eval("SoLuong") %> x <%# Eval("DonGia", "{0:N0} đ") %></small>
                                            </div>
                                            <div class="fw-bold text-end">
                                                <%# Eval("ThanhTien", "{0:N0} đ") %>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>

                            <hr />

                            <div class="d-flex justify-content-between align-items-center mb-4 mt-3">
                                <span class="fs-5 fw-semibold">Tổng thanh toán:</span>
                                <asp:Label ID="lblTongThanhToan" runat="server" CssClass="fs-4 fw-bold text-danger" Text="0 đ"></asp:Label>
                            </div>

                            <asp:Button ID="btnDatHang" runat="server" Text="Xác Nhận Đặt Hàng"
                                CssClass="btn btn-success btn-lg w-100 fw-bold" OnClick="btnDatHang_Click" />
                        </div>
                    </div>
                </div>

            </div>
        </asp:Panel>

    </div>
</asp:Content>
