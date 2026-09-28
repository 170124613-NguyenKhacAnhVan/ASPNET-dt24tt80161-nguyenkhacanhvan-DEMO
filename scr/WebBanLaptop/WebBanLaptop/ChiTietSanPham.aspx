<%@ Page Title="Chi Tiết Sản Phẩm" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ChiTietSanPham.aspx.cs" Inherits="WebBanLaptop.ChiTietSanPham" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .thumb-img {
            width: 75px;
            height: 60px;
            object-fit: contain;
            cursor: pointer;
            transition: all 0.2s ease;
        }

            .thumb-img:hover, .thumb-img.active {
                border-color: #dc3545 !important;
                transform: scale(1.05);
            }

        .spec-table th {
            width: 38%;
            background-color: #f8f9fa;
            font-weight: 600;
            color: #495057;
        }

        .product-title-card {
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            height: 2.6rem;
        }
    </style>

    <main class="py-2">
        <!-- 1. BREADCRUMB (Đường dẫn điều hướng) -->
        <nav aria-label="breadcrumb" class="mb-3">
            <ol class="breadcrumb bg-white p-2 px-3 rounded shadow-sm border mb-0">
                <li class="breadcrumb-item"><a href="Default.aspx" class="text-decoration-none">Trang chủ</a></li>
                <li class="breadcrumb-item">
                    <asp:HyperLink ID="lnkBreadcrumbDanhMuc" runat="server" CssClass="text-decoration-none" />
                </li>
                <li class="breadcrumb-item active text-truncate" aria-current="page" style="max-width: 350px;">
                    <asp:Literal ID="litBreadcrumbTenSP" runat="server" />
                </li>
            </ol>
        </nav>

        <!-- 2. KHỐI THÔNG TIN CHÍNH (ẢNH + GIÁ + NÚT MUA) -->
        <div class="bg-white rounded p-4 mb-4 shadow-sm border">
            <div class="row g-4">
                <!-- Cột trái: Hình ảnh sản phẩm -->
                <div class="col-md-5 text-center">
                    <div class="border rounded p-3 mb-3 bg-white">
                        <asp:Image ID="imgAnhChinh" runat="server" ClientIDMode="Static"
                            CssClass="img-fluid" Style="height: 320px; object-fit: contain;" />
                    </div>

                    <!-- Danh sách ảnh phụ từ bảng tblHinhAnhSanPham -->
                    <div class="d-flex justify-content-center flex-wrap gap-2">
                        <asp:Repeater ID="rptHinhAnh" runat="server">
                            <ItemTemplate>
                                <img src='<%# Eval("DuongDanAnh") %>'
                                    alt="Ảnh chi tiết"
                                    class="border rounded p-1 bg-white thumb-img"
                                    onclick="changeMainImage(this.src)" />
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>

                <!-- Cột phải: Tên, Giá, Tóm tắt & Đặt hàng -->
                <div class="col-md-7">
                    <div class="d-flex align-items-center gap-2 mb-2">
                        <span class="badge bg-primary">
                            <asp:Literal ID="litThuongHieu" runat="server" /></span>
                        <span class="badge bg-secondary">
                            <asp:Literal ID="litDanhMuc" runat="server" /></span>
                        <asp:Label ID="lblTinhTrang" runat="server" CssClass="badge bg-success" />
                    </div>

                    <h2 class="fw-bold text-dark fs-4 mb-3">
                        <asp:Literal ID="litTenSanPham" runat="server" />
                    </h2>

                    <!-- Khung giá bán -->
                    <div class="bg-light p-3 rounded border mb-3 d-flex align-items-baseline gap-3">
                        <span class="text-danger fw-bold fs-2">
                            <asp:Literal ID="litGiaHienThi" runat="server" />
                        </span>
                        <asp:Panel ID="pnlGiaGoc" runat="server" CssClass="d-inline">
                            <span class="text-decoration-line-through text-muted fs-5 me-2">
                                <asp:Literal ID="litGiaGoc" runat="server" />
                            </span>
                            <span class="badge bg-danger">Giảm
                                <asp:Literal ID="litPhanTramGiam" runat="server" />%
                            </span>
                        </asp:Panel>
                    </div>

                    <!-- Tóm tắt cấu hình nổi bật -->
                    <div class="row row-cols-2 g-2 mb-3 small">
                        <div class="col">
                            <div class="p-2 border rounded bg-white">
                                <i class="bi bi-cpu text-danger me-1"></i><strong>CPU:</strong>
                                <asp:Literal ID="litTomTatCPU" runat="server" />
                            </div>
                        </div>
                        <div class="col">
                            <div class="p-2 border rounded bg-white">
                                <i class="bi bi-memory text-danger me-1"></i><strong>RAM:</strong>
                                <asp:Literal ID="litTomTatRAM" runat="server" />
                            </div>
                        </div>
                        <div class="col">
                            <div class="p-2 border rounded bg-white">
                                <i class="bi bi-hdd text-danger me-1"></i><strong>Ổ cứng:</strong>
                                <asp:Literal ID="litTomTatOCung" runat="server" />
                            </div>
                        </div>
                        <div class="col">
                            <div class="p-2 border rounded bg-white">
                                <i class="bi bi-gpu-card text-danger me-1"></i><strong>VGA:</strong>
                                <asp:Literal ID="litTomTatVGA" runat="server" />
                            </div>
                        </div>
                    </div>

                    <!-- Khuyến mãi đi kèm -->
                    <div class="border border-danger border-opacity-50 rounded p-3 mb-4 bg-danger bg-opacity-10">
                        <h6 class="fw-bold text-danger mb-2"><i class="bi bi-gift-fill me-1"></i>Quà tặng & Ưu đãi kèm theo:</h6>
                        <ul class="mb-0 small ps-3">
                            <li>Tặng Balo Laptop chống sốc cao cấp & Chuột không dây.</li>
                            <li>Bảo hành chính hãng 12 - 24 tháng, lỗi 1 đổi 1 trong 30 ngày đầu.</li>
                            <li>Miễn phí cài đặt phần mềm và vệ sinh máy trọn đời.</li>
                        </ul>
                    </div>

                    <!-- Chọn số lượng và Nút Mua hàng -->
                    <asp:Panel ID="pnlMuaHang" runat="server">
                        <div class="d-flex align-items-center gap-3 mb-3">
                            <label class="fw-semibold">Số lượng:</label>
                            <asp:TextBox ID="txtSoLuong" runat="server" Text="1" TextMode="Number"
                                CssClass="form-control text-center" Style="width: 90px;" min="1" max="10" />
                            <span class="text-muted small">(Còn
                                <asp:Literal ID="litSoLuongTon" runat="server" />
                                sản phẩm)
                            </span>
                        </div>

                        <div class="d-flex gap-2">
                            <asp:LinkButton ID="btnMuaNgay" runat="server" CssClass="btn btn-danger btn-lg flex-grow-1 fw-bold" OnClick="btnMuaNgay_Click">
                                <i class="bi bi-bag-check-fill me-1"></i> MUA NGAY
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnThemVaoGio" runat="server" CssClass="btn btn-outline-danger btn-lg flex-grow-1 fw-bold" OnClick="btnThemVaoGio_Click">
                                <i class="bi bi-cart-plus-fill me-1"></i> THÊM VÀO GIỎ
                            </asp:LinkButton>
                        </div>
                    </asp:Panel>

                    <!-- Thông báo khi thêm giỏ hàng -->
                    <asp:Label ID="lblThongBao" runat="server" CssClass="d-block mt-3 fw-semibold" Visible="false" />
                </div>
            </div>
        </div>

        <!-- 3. MÔ TẢ SẢN PHẨM & BẢNG THÔNG SỐ KỸ THUẬT CHI TIẾT -->
        <div class="row g-4 mb-4">
            <!-- Cột trái: Mô tả sản phẩm -->
            <div class="col-md-7">
                <div class="bg-white rounded p-4 shadow-sm border h-100">
                    <h4 class="fw-bold border-bottom pb-2 mb-3 text-uppercase fs-5">
                        <i class="bi bi-file-earmark-text me-1 text-danger"></i>Đặc điểm nổi bật
                    </h4>
                    <div class="text-secondary" style="line-height: 1.8;">
                        <asp:Literal ID="litMoTa" runat="server" />
                    </div>
                </div>
            </div>

            <!-- Cột phải: Bảng thông số kỹ thuật đầy đủ từ tblThongSoKyThuat -->
            <div class="col-md-5">
                <div class="bg-white rounded p-4 shadow-sm border h-100">
                    <h4 class="fw-bold border-bottom pb-2 mb-3 text-uppercase fs-5">
                        <i class="bi bi-gear-wide-connected me-1 text-danger"></i>Thông số kỹ thuật
                    </h4>
                    <table class="table table-bordered table-striped spec-table small mb-0">
                        <tbody>
                            <tr>
                                <th>CPU</th>
                                <td>
                                    <asp:Literal ID="litCPU" runat="server" /></td>
                            </tr>
                            <tr>
                                <th>RAM</th>
                                <td>
                                    <asp:Literal ID="litRAM" runat="server" /></td>
                            </tr>
                            <tr>
                                <th>Ổ cứng</th>
                                <td>
                                    <asp:Literal ID="litOCung" runat="server" /></td>
                            </tr>
                            <tr>
                                <th>Card đồ họa</th>
                                <td>
                                    <asp:Literal ID="litCardDoHoa" runat="server" /></td>
                            </tr>
                            <tr>
                                <th>Màn hình</th>
                                <td>
                                    <asp:Literal ID="litManHinh" runat="server" /></td>
                            </tr>
                            <tr>
                                <th>Độ phân giải</th>
                                <td>
                                    <asp:Literal ID="litDoPhanGiai" runat="server" /></td>
                            </tr>
                            <tr>
                                <th>Tần số quét</th>
                                <td>
                                    <asp:Literal ID="litTanSoQuet" runat="server" /></td>
                            </tr>
                            <tr>
                                <th>Hệ điều hành</th>
                                <td>
                                    <asp:Literal ID="litHeDieuHanh" runat="server" /></td>
                            </tr>
                            <tr>
                                <th>Pin</th>
                                <td>
                                    <asp:Literal ID="litPin" runat="server" /></td>
                            </tr>
                            <tr>
                                <th>Trọng lượng</th>
                                <td>
                                    <asp:Literal ID="litTrongLuong" runat="server" /></td>
                            </tr>
                            <tr>
                                <th>Màu sắc</th>
                                <td>
                                    <asp:Literal ID="litMauSac" runat="server" /></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- 4. SẢN PHẨM CÙNG DANH MỤC -->
        <div class="bg-white rounded p-3 mb-4 shadow-sm border">
            <div class="d-flex justify-content-between align-items-center border-bottom pb-2 mb-3">
                <h4 class="fw-bold mb-0 text-uppercase text-dark fs-5">Sản Phẩm Tương Tự</h4>
            </div>
            <div class="row row-cols-2 row-cols-md-4 g-3">
                <asp:Repeater ID="rptSanPhamLienQuan" runat="server">
                    <ItemTemplate>
                        <div class="col">
                            <div class="card h-100 shadow-sm border-light">
                                <a href='<%# "ChiTietSanPham.aspx?id=" + Eval("MaSanPham") %>'>
                                    <img src='<%# Eval("AnhDaiDien") %>' class="card-img-top p-3" style="height: 180px; object-fit: contain;" alt='<%# Eval("TenSanPham") %>'>
                                </a>
                                <div class="card-body pt-0">
                                    <a href='<%# "ChiTietSanPham.aspx?id=" + Eval("MaSanPham") %>' class="text-decoration-none text-dark">
                                        <h6 class="card-title product-title-card"><%# Eval("TenSanPham") %></h6>
                                    </a>
                                    <div class="text-danger fw-bold fs-5"><%# Eval("GiaHienThi", "{0:N0}đ") %></div>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </main>

    <!-- Script đổi ảnh chính khi click vào ảnh thu nhỏ -->
    <script>
        function changeMainImage(src) {
            var mainImg = document.getElementById('imgAnhChinh');
            if (mainImg) {
                mainImg.src = src;
            }
        }
    </script>

</asp:Content>
