<%@ Page Title="Quản lý Đơn hàng" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="QuanLyDonHang.aspx.cs" Inherits="WebBanLaptop.Admin.QuanLyDonHang" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Header -->
    <div class="d-flex flex-column flex-sm-row justify-content-between align-items-sm-center mb-4 gap-2 bg-white p-3 px-4 rounded-4 shadow-sm">
        <div>
            <h5 class="fw-bold text-dark mb-0"><i class="bi bi-cart-check text-success me-2"></i>QUẢN LÝ ĐƠN HÀNG</h5>
            <small class="text-secondary">Theo dõi và xử lý đơn hàng của khách</small>
        </div>
    </div>

    <!-- Panel Danh sách Đơn hàng -->
    <asp:Panel ID="pnlDanhSach" runat="server">
        <!-- Bộ lọc -->
        <div class="card border-0 shadow-sm rounded-4 mb-4">
            <div class="card-body p-3 row g-2">
                <div class="col-md-5">
                    <div class="input-group">
                        <asp:TextBox ID="txtTimKiem" runat="server" CssClass="form-control" placeholder="Tìm tên khách, số điện thoại..."></asp:TextBox>
                        <asp:Button ID="btnTim" runat="server" Text="Tìm kiếm" CssClass="btn btn-success" OnClick="BoLoc_Changed" />
                    </div>
                </div>
                <div class="col-md-3">
                    <asp:DropDownList ID="ddlLocTrangThai" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="BoLoc_Changed">
                        <asp:ListItem Value="-1">-- Tất cả trạng thái --</asp:ListItem>
                        <asp:ListItem Value="0">Chờ duyệt</asp:ListItem>
                        <asp:ListItem Value="1">Đang giao hàng</asp:ListItem>
                        <asp:ListItem Value="2">Hoàn thành</asp:ListItem>
                        <asp:ListItem Value="3">Đã hủy</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
        </div>

        <!-- GridView Danh sách -->
        <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
            <asp:GridView ID="gvDonHang" runat="server" AutoGenerateColumns="False"
                DataKeyNames="MaDonHang" CssClass="table table-hover align-middle mb-0 small" GridLines="None"
                OnRowCommand="gvDonHang_RowCommand" EmptyDataText="Không có đơn hàng nào.">
                <HeaderStyle CssClass="bg-light text-secondary fw-semibold border-bottom" />
                <Columns>
                    <asp:BoundField DataField="MaDonHang" HeaderText="Mã ĐH" ItemStyle-CssClass="fw-bold ps-4" HeaderStyle-CssClass="ps-4 py-3" />
                    <asp:BoundField DataField="HoTenNguoiNhan" HeaderText="Khách hàng" />
                    <asp:BoundField DataField="SoDienThoai" HeaderText="SĐT" />
                    <asp:BoundField DataField="NgayTao" HeaderText="Ngày đặt" DataFormatString="{0:dd/MM/yyyy HH:mm}" />
                    <asp:BoundField DataField="TongTien" HeaderText="Tổng tiền" DataFormatString="{0:N0} đ" ItemStyle-CssClass="text-danger fw-bold" />

                    <asp:TemplateField HeaderText="Trạng thái">
                        <ItemTemplate>
                            <span class='badge rounded-pill 
                                <%# Convert.ToInt32(Eval("TrangThai")) == 0 ? "bg-warning text-dark" : 
                                    Convert.ToInt32(Eval("TrangThai")) == 1 ? "bg-primary" : 
                                    Convert.ToInt32(Eval("TrangThai")) == 2 ? "bg-success" : "bg-danger" %>'>
                                <%# Convert.ToInt32(Eval("TrangThai")) == 0 ? "Chờ duyệt" : 
                                    Convert.ToInt32(Eval("TrangThai")) == 1 ? "Đang giao" : 
                                    Convert.ToInt32(Eval("TrangThai")) == 2 ? "Hoàn thành" : "Đã hủy" %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Thao tác" ItemStyle-CssClass="text-end pe-4" HeaderStyle-CssClass="text-end pe-4">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnChiTiet" runat="server" CommandName="XemChiTiet" CommandArgument='<%# Eval("MaDonHang") %>' CssClass="btn btn-sm btn-outline-info rounded-3">
                                <i class="bi bi-eye"></i> Xem / Xử lý
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </asp:Panel>

    <!-- Panel Chi tiết Đơn hàng -->
    <asp:Panel ID="pnlChiTiet" runat="server" Visible="false" CssClass="card border-0 shadow-sm rounded-4 mb-4">
        <div class="card-header bg-success text-white p-3 px-4 d-flex justify-content-between align-items-center">
            <h6 class="fw-bold mb-0">CHI TIẾT ĐƠN HÀNG #<asp:Label ID="lblMaDonHang" runat="server"></asp:Label></h6>
            <asp:LinkButton ID="btnDongChiTiet" runat="server" CssClass="btn-close btn-close-white" OnClick="btnDongChiTiet_Click"></asp:LinkButton>
        </div>
        <div class="card-body p-4">
            <div class="row mb-4">
                <div class="col-md-6">
                    <p class="mb-1">
                        <strong>Người nhận:</strong>
                        <asp:Label ID="lblKhachHang" runat="server"></asp:Label>
                    </p>
                    <p class="mb-1">
                        <strong>Điện thoại:</strong>
                        <asp:Label ID="lblSDT" runat="server"></asp:Label>
                    </p>
                    <p class="mb-1">
                        <strong>Địa chỉ:</strong>
                        <asp:Label ID="lblDiaChi" runat="server"></asp:Label>
                    </p>
                </div>
                <div class="col-md-6">
                    <p class="mb-1">
                        <strong>Ngày đặt:</strong>
                        <asp:Label ID="lblNgayDat" runat="server"></asp:Label>
                    </p>
                    <p class="mb-1">
                        <strong>Thanh toán:</strong>
                        <asp:Label ID="lblPhuongThuc" runat="server"></asp:Label>
                    </p>
                    <p class="mb-1">
                        <strong>Ghi chú:</strong>
                        <asp:Label ID="lblGhiChu" runat="server"></asp:Label>
                    </p>
                </div>
            </div>

            <h6 class="fw-bold mb-3">Sản phẩm đã đặt:</h6>
            <asp:GridView ID="gvChiTiet" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered align-middle text-center small">
                <HeaderStyle CssClass="bg-light" />
                <Columns>
                    <asp:BoundField DataField="TenSanPham" HeaderText="Tên Laptop" ItemStyle-CssClass="text-start" />
                    <asp:TemplateField HeaderText="Hình ảnh">
                        <ItemTemplate>
                            <img src='<%# Eval("AnhDaiDien", "~/Images/{0}") %>' onerror="this.onerror=null; this.src='/Images/no-image.png';" style="width: 50px;" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="SoLuong" HeaderText="SL" />
                    <asp:BoundField DataField="DonGia" HeaderText="Đơn giá" DataFormatString="{0:N0} đ" />
                    <asp:BoundField DataField="ThanhTien" HeaderText="Thành tiền" DataFormatString="{0:N0} đ" ItemStyle-CssClass="fw-bold text-danger" />
                </Columns>
            </asp:GridView>

            <div class="d-flex justify-content-between align-items-center mt-4 p-3 bg-light rounded border">
                <div class="d-flex align-items-center gap-2">
                    <span class="fw-bold">Cập nhật trạng thái:</span>
                    <asp:DropDownList ID="ddlCapNhatTrangThai" runat="server" CssClass="form-select w-auto">
                        <asp:ListItem Value="0">Chờ duyệt</asp:ListItem>
                        <asp:ListItem Value="1">Đang giao hàng</asp:ListItem>
                        <asp:ListItem Value="2">Hoàn thành</asp:ListItem>
                        <asp:ListItem Value="3">Hủy đơn</asp:ListItem>
                    </asp:DropDownList>
                    <asp:Button ID="btnLuuTrangThai" runat="server" Text="Lưu thay đổi" CssClass="btn btn-success" OnClick="btnLuuTrangThai_Click" />
                </div>
                <h4 class="mb-0 text-danger fw-bold">Tổng:
                    <asp:Label ID="lblTongTienDon" runat="server"></asp:Label></h4>
            </div>
        </div>
    </asp:Panel>
</asp:Content>
