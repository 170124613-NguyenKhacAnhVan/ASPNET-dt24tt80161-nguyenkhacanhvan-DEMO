<%@ Page Title="Trang quản trị - Tổng quan" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="TrangQuanTri.aspx.cs" Inherits="WebBanLaptop.Admin.TrangQuanTri" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container my-4">

        <!-- ================= 1. HEADER QUẢN TRỊ & BỘ LỌC ================= -->
        <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center mb-4 gap-3 bg-white p-4 rounded-4 shadow-sm border-start border-5 border-danger">
            <div>
                <h4 class="fw-bold text-danger mb-1">
                    <i class="bi bi-speedometer2 me-2"></i>BẢNG ĐIỀU KHIỂN & TỔNG QUAN
                </h4>
                <p class="text-secondary small mb-0">Theo dõi hoạt động kinh doanh hệ thống Máy tính Đăng Khoa</p>
            </div>

            <!-- Control cơ bản: DropDownList có AutoPostBack để lọc theo năm -->
            <div class="d-flex align-items-center gap-2">
                <label class="small fw-semibold text-secondary text-nowrap">Năm thống kê:</label>
                <asp:DropDownList ID="ddlNamThongKe" runat="server" AutoPostBack="true"
                    CssClass="form-select form-select-sm fw-bold border-danger text-danger"
                    Style="width: 110px;"
                    OnSelectedIndexChanged="ddlNamThongKe_SelectedIndexChanged">
                    <asp:ListItem Value="2026" Selected="True">Năm 2026</asp:ListItem>
                    <asp:ListItem Value="2025">Năm 2025</asp:ListItem>
                </asp:DropDownList>
            </div>
        </div>

        <!-- ================= 2. MENU ĐIỀU HƯỚNG NHANH CHO ADMIN ================= -->
        <div class="row g-2 mb-4">
            <div class="col-6 col-md-3">
                <a href="QuanLySanPham.aspx" class="btn btn-outline-danger w-100 py-2 fw-semibold rounded-3 shadow-sm bg-white text-danger">
                    <i class="bi bi-laptop me-1"></i>Quản lý Laptop
                </a>
            </div>
            <div class="col-6 col-md-3">
                <a href="QuanLyDanhMuc.aspx" class="btn btn-outline-danger w-100 py-2 fw-semibold rounded-3 shadow-sm bg-white text-danger">
                    <i class="bi bi-tags me-1"></i>Quản lý Danh mục
                </a>
            </div>
            <div class="col-6 col-md-3">
                <a href="QuanLyDonHang.aspx" class="btn btn-outline-danger w-100 py-2 fw-semibold rounded-3 shadow-sm bg-white text-danger">
                    <i class="bi bi-receipt me-1"></i>Quản lý Đơn hàng
                </a>
            </div>
            <div class="col-6 col-md-3">
                <a href="QuanLyNguoiDung.aspx" class="btn btn-outline-danger w-100 py-2 fw-semibold rounded-3 shadow-sm bg-white text-danger">
                    <i class="bi bi-people me-1"></i>Quản lý Khách hàng
                </a>
            </div>
        </div>

        <!-- ================= 3. BỐN THẺ THỐNG KÊ TỔNG QUAN (KPI CARDS) ================= -->
        <div class="row g-3 mb-4">
            <!-- Tổng doanh thu -->
            <div class="col-12 col-sm-6 col-xl-3">
                <div class="card border-0 shadow-sm rounded-4 h-100">
                    <div class="card-body p-4 d-flex align-items-center justify-content-between">
                        <div>
                            <span class="text-secondary small fw-semibold d-block mb-1">TỔNG DOANH THU</span>
                            <h4 class="fw-bold text-danger mb-1">
                                <asp:Label ID="lblTongDoanhThu" runat="server" Text="0 đ"></asp:Label>
                            </h4>
                            <small class="text-success"><i class="bi bi-arrow-up-right"></i>+12.5% so với tháng trước</small>
                        </div>
                        <div class="bg-danger bg-opacity-10 text-danger rounded-4 p-3 d-flex align-items-center justify-content-center" style="width: 56px; height: 56px;">
                            <i class="bi bi-cash-coin fs-3"></i>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Tổng đơn hàng -->
            <div class="col-12 col-sm-6 col-xl-3">
                <div class="card border-0 shadow-sm rounded-4 h-100">
                    <div class="card-body p-4 d-flex align-items-center justify-content-between">
                        <div>
                            <span class="text-secondary small fw-semibold d-block mb-1">TỔNG ĐƠN HÀNG</span>
                            <h4 class="fw-bold text-dark mb-1">
                                <asp:Label ID="lblTongDonHang" runat="server" Text="0"></asp:Label>
                            </h4>
                            <small class="text-primary"><i class="bi bi-box-seam"></i>Đơn hàng trong năm</small>
                        </div>
                        <div class="bg-primary bg-opacity-10 text-primary rounded-4 p-3 d-flex align-items-center justify-content-center" style="width: 56px; height: 56px;">
                            <i class="bi bi-cart-check fs-3"></i>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Tổng sản phẩm -->
            <div class="col-12 col-sm-6 col-xl-3">
                <div class="card border-0 shadow-sm rounded-4 h-100">
                    <div class="card-body p-4 d-flex align-items-center justify-content-between">
                        <div>
                            <span class="text-secondary small fw-semibold d-block mb-1">SẢN PHẨM ĐANG BÁN</span>
                            <h4 class="fw-bold text-dark mb-1">
                                <asp:Label ID="lblTongSanPham" runat="server" Text="0"></asp:Label>
                            </h4>
                            <small class="text-warning text-dark"><i class="bi bi-laptop"></i>Mẫu laptop sẵn hàng</small>
                        </div>
                        <div class="bg-warning bg-opacity-25 text-dark rounded-4 p-3 d-flex align-items-center justify-content-center" style="width: 56px; height: 56px;">
                            <i class="bi bi-pc-display fs-3"></i>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Tổng khách hàng (Lấy trực tiếp từ tblUser) -->
            <div class="col-12 col-sm-6 col-xl-3">
                <div class="card border-0 shadow-sm rounded-4 h-100">
                    <div class="card-body p-4 d-flex align-items-center justify-content-between">
                        <div>
                            <span class="text-secondary small fw-semibold d-block mb-1">TÀI KHOẢN KHÁCH HÀNG</span>
                            <h4 class="fw-bold text-dark mb-1">
                                <asp:Label ID="lblTongKhachHang" runat="server" Text="0"></asp:Label>
                            </h4>
                            <small class="text-secondary"><i class="bi bi-person-check"></i>Thành viên hệ thống</small>
                        </div>
                        <div class="bg-success bg-opacity-10 text-success rounded-4 p-3 d-flex align-items-center justify-content-center" style="width: 56px; height: 56px;">
                            <i class="bi bi-people fs-3"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- ================= 4. KHU VỰC BIỂU ĐỒ (CHART.JS + BOOTSTRAP) ================= -->
        <div class="row g-4 mb-4">
            <!-- Biểu đồ cột: Doanh thu 12 tháng -->
            <div class="col-lg-8">
                <div class="card border-0 shadow-sm rounded-4 h-100">
                    <div class="card-header bg-white border-bottom p-4 d-flex justify-content-between align-items-center">
                        <h6 class="fw-bold text-dark mb-0">
                            <i class="bi bi-bar-chart-line-fill text-danger me-2"></i>BIỂU ĐỒ DOANH THU THEO THÁNG (TRIỆU VNĐ)
                        </h6>
                    </div>
                    <div class="card-body p-4">
                        <canvas id="revenueChart" style="max-height: 310px;"></canvas>
                    </div>
                </div>
            </div>

            <!-- Biểu đồ tròn: Tỷ lệ trạng thái đơn hàng -->
            <div class="col-lg-4">
                <div class="card border-0 shadow-sm rounded-4 h-100">
                    <div class="card-header bg-white border-bottom p-4">
                        <h6 class="fw-bold text-dark mb-0">
                            <i class="bi bi-pie-chart-fill text-danger me-2"></i>TỶ LỆ TRẠNG THÁI ĐƠN HÀNG
                        </h6>
                    </div>
                    <div class="card-body p-4 d-flex flex-column justify-content-center align-items-center">
                        <canvas id="orderStatusChart" style="max-height: 250px;"></canvas>
                    </div>
                </div>
            </div>
        </div>

        <!-- ================= 5. CONTROL NÂNG CAO: GRIDVIEW & REPEATER ================= -->
        <div class="row g-4">

            <!-- Cột trái (8 phần): GridView Đơn hàng mới nhất (Có phân trang & TemplateField) -->
            <div class="col-lg-8">
                <div class="card border-0 shadow-sm rounded-4 h-100">
                    <div class="card-header bg-white border-bottom p-4 d-flex justify-content-between align-items-center">
                        <h6 class="fw-bold text-dark mb-0">
                            <i class="bi bi-clock-history text-danger me-2"></i>ĐƠN ĐẶT HÀNG MỚI NHẤT
                        </h6>
                        <a href="QuanLyDonHang.aspx" class="text-danger small fw-semibold text-decoration-none">Xem tất cả <i class="bi bi-arrow-right"></i></a>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <asp:GridView ID="gvDonHangMoi" runat="server"
                                AutoGenerateColumns="False"
                                AllowPaging="True" PageSize="5"
                                OnPageIndexChanging="gvDonHangMoi_PageIndexChanging"
                                CssClass="table table-hover align-middle mb-0 small"
                                GridLines="None"
                                EmptyDataText="Chưa có đơn hàng nào.">
                                <HeaderStyle CssClass="bg-light text-secondary fw-semibold" />
                                <Columns>
                                    <asp:BoundField DataField="MaDH" HeaderText="Mã ĐH" ItemStyle-CssClass="fw-bold ps-4" HeaderStyle-CssClass="ps-4 py-3" />
                                    <asp:BoundField DataField="KhachHang" HeaderText="Khách hàng" HeaderStyle-CssClass="py-3" />
                                    <asp:BoundField DataField="NgayDat" HeaderText="Ngày đặt" DataFormatString="{0:dd/MM/yyyy}" HeaderStyle-CssClass="py-3" />
                                    <asp:BoundField DataField="TongTien" HeaderText="Tổng tiền" DataFormatString="{0:N0} đ" ItemStyle-CssClass="fw-bold text-danger" HeaderStyle-CssClass="py-3" />

                                    <asp:TemplateField HeaderText="Trạng thái" HeaderStyle-CssClass="py-3">
                                        <ItemTemplate>
                                            <span class='badge rounded-pill <%# LayMauTrangThai(Eval("TrangThai").ToString()) %>'>
                                                <%# Eval("TrangThai") %>
                                            </span>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <PagerStyle CssClass="pagination-ys p-3" HorizontalAlign="Right" />
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Cột phải (4 phần): Repeater + Bootstrap Progress Bar thống kê Hãng bán chạy -->
            <div class="col-lg-4">
                <div class="card border-0 shadow-sm rounded-4 h-100">
                    <div class="card-header bg-white border-bottom p-4">
                        <h6 class="fw-bold text-dark mb-0">
                            <i class="bi bi-trophy-fill text-warning me-2"></i>THƯƠNG HIỆU BÁN CHẠY
                        </h6>
                    </div>
                    <div class="card-body p-4">
                        <asp:Repeater ID="rptHangBanChay" runat="server">
                            <ItemTemplate>
                                <div class="mb-3">
                                    <div class="d-flex justify-content-between small mb-1">
                                        <span class="fw-semibold"><%# Eval("TenHang") %></span>
                                        <span class="text-secondary"><%# Eval("SoLuong") %> máy (<%# Eval("TyLe") %>%)</span>
                                    </div>
                                    <!-- Thanh Progress Bar chuẩn của Bootstrap 5 -->
                                    <div class="progress" style="height: 8px;">
                                        <div class="progress-bar bg-danger" role="progressbar"
                                            style='width: <%# Eval("TyLe") %>%;'
                                            aria-valuenow='<%# Eval("TyLe") %>' aria-valuemin="0" aria-valuemax="100">
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <!-- Nhúng thư viện Chart.js (1 dòng CDN) để vẽ biểu đồ -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            // 1. Vẽ biểu đồ Cột: Doanh thu 12 tháng (Nhận chuỗi dữ liệu từ C# Server)
            var ctxRevenue = document.getElementById('revenueChart').getContext('2d');
            new Chart(ctxRevenue, {
                type: 'bar',
                data: {
                    labels: ['T1', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'T8', 'T9', 'T10', 'T11', 'T12'],
                    datasets: [{
                        label: 'Doanh thu (Triệu VNĐ)',
                        data: [<%= ChuoiDoanhThu12Thang %>],
                        backgroundColor: 'rgba(220, 53, 69, 0.85)',
                        borderColor: '#dc3545',
                        borderWidth: 1,
                        borderRadius: 6
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: { legend: { display: false } }
                }
            });

            // 2. Vẽ biểu đồ Tròn: Tỷ lệ trạng thái đơn hàng
            var ctxStatus = document.getElementById('orderStatusChart').getContext('2d');
            new Chart(ctxStatus, {
                type: 'doughnut',
                data: {
                    labels: ['Đã giao thành công', 'Đang vận chuyển', 'Chờ xác nhận', 'Đã hủy'],
                    datasets: [{
                        data: [<%= ChuoiTyLeDonHang %>],
                        backgroundColor: ['#198754', '#0d6efd', '#ffc107', '#dc3545'],
                        borderWidth: 2
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: { position: 'bottom' }
                    }
                }
            });
        });
    </script>
</asp:Content>
