<%@ Page Title="Giỏ hàng" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="GioHang.aspx.cs" Inherits="WebBanLaptop.GioHang" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container my-4">
        <h2 class="mb-4 fw-bold">Giỏ Hàng Của Bạn</h2>

        <!-- Thông báo khi giỏ hàng trống -->
        <asp:Panel ID="pnlGioHangTrong" runat="server" Visible="false" CssClass="alert alert-info text-center py-4 shadow-sm">
            <h5>Giỏ hàng của bạn đang trống!</h5>
            <a href="Default.aspx" class="btn btn-primary mt-3 px-4">Quay lại mua sắm</a>
        </asp:Panel>

        <!-- Bảng danh sách sản phẩm -->
        <asp:Panel ID="pnlDanhSachGioHang" runat="server">
            <div class="table-responsive">
                <asp:GridView ID="gvGioHang" runat="server" AutoGenerateColumns="False"
                    CssClass="table table-bordered table-hover align-middle text-center shadow-sm"
                    DataKeyNames="MaSanPham" OnRowCommand="gvGioHang_RowCommand">

                    <HeaderStyle CssClass="table-light" />

                    <Columns>
                        <asp:TemplateField HeaderText="Hình ảnh">
                            <ItemTemplate>
                                <img src='<%# Eval("AnhDaiDien", "Images/Sanpham/{0}") %>' alt="Laptop" style="width: 80px; height: auto;" class="img-thumbnail" />
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:BoundField DataField="TenSanPham" HeaderText="Tên Laptop" ItemStyle-CssClass="text-start fw-semibold" />

                        <asp:BoundField DataField="DonGia" HeaderText="Đơn giá" DataFormatString="{0:N0} đ" />

                        <asp:TemplateField HeaderText="Số lượng">
                            <ItemTemplate>
                                <div class="d-flex justify-content-center align-items-center">
                                    <asp:TextBox ID="txtSoLuong" runat="server" Text='<%# Eval("SoLuong") %>'
                                        TextMode="Number" min="1" CssClass="form-control text-center" Style="width: 75px;">
                                    </asp:TextBox>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:BoundField DataField="ThanhTien" HeaderText="Thành tiền" DataFormatString="{0:N0} đ" ItemStyle-CssClass="fw-bold text-danger" />

                        <asp:TemplateField HeaderText="Thao tác">
                            <ItemTemplate>
                                <asp:Button ID="btnXoa" runat="server" Text="Xóa"
                                    CommandName="Xoa" CommandArgument='<%# Eval("MaSanPham") %>'
                                    CssClass="btn btn-sm btn-danger" OnClientClick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này khỏi giỏ hàng?');" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>

            <div class="d-flex justify-content-between align-items-center mt-4 p-3 bg-light rounded border shadow-sm">
                <a href="Default.aspx" class="btn btn-outline-primary">← Tiếp tục mua hàng</a>

                <div class="d-flex align-items-center gap-3">
                    <asp:Button ID="btnCapNhatTatCa" runat="server" Text="↻ Cập nhật giỏ hàng"
                        CssClass="btn btn-warning fw-semibold" OnClick="btnCapNhatTatCa_Click" />

                    <h4 class="mb-0 mx-3">Tổng:
                        <asp:Label ID="lblTongTien" runat="server" CssClass="text-danger fw-bold" Text="0 đ"></asp:Label></h4>

                    <asp:Button ID="btnThanhToan" runat="server" Text="Tiến Hành Đặt Hàng →"
                        CssClass="btn btn-success btn-lg px-4" OnClick="btnThanhToan_Click" />
                </div>
            </div>
        </asp:Panel>
    </div>
    <script type="text/javascript">
        function tangSoLuong(btn) {
            var input = btn.parentElement.querySelector('.qty-input');
            var currentVal = parseInt(input.value);
            if (!isNaN(currentVal)) {
                input.value = currentVal + 1;
            }
        }

        function giamSoLuong(btn) {
            var input = btn.parentElement.querySelector('.qty-input');
            var currentVal = parseInt(input.value);
            if (!isNaN(currentVal) && currentVal > 1) {
                input.value = currentVal - 1;
            }
        }
    </script>
</asp:Content>
