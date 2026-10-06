<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebBanLaptop._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <main>
        <div id="homeCarousel" class="carousel slide mb-4" data-bs-ride="carousel">
            <div class="carousel-indicators">
                <button type="button" data-bs-target="#homeCarousel" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                <button type="button" data-bs-target="#homeCarousel" data-bs-slide-to="1" aria-label="Slide 2"></button>
                <button type="button" data-bs-target="#homeCarousel" data-bs-slide-to="2" aria-label="Slide 3"></button>
            </div>
            <div class="carousel-inner rounded shadow-sm">
                <div class="carousel-item active">
                    <img src="Images/AnhBia/1.png" class="d-block w-100" alt="Khuyến mãi 1" style="object-fit: cover; height: 400px;">
                </div>
                <div class="carousel-item">
                    <img src="Images/AnhBia/2.png" class="d-block w-100" alt="Khuyến mãi 2" style="object-fit: cover; height: 400px;">
                </div>
                <div class="carousel-item">
                    <img src="Images/AnhBia/3.png" class="d-block w-100" alt="Khuyến mãi 3" style="object-fit: cover; height: 400px;">
                </div>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#homeCarousel" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#homeCarousel" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
        </div>

        <div class="row text-center mb-4 g-2">
            <asp:Repeater ID="rptThuongHieu" runat="server">
                <ItemTemplate>
                    <div class="col-4 col-md-2">
                        <asp:HyperLink ID="lnkThuongHieu" runat="server"
                            NavigateUrl='<%# "~/Default.aspx?thuonghieu=" + Eval("MaThuongHieu") %>'
                            CssClass="brand-box bg-white border rounded p-3 d-block shadow-sm"
                            ToolTip='<%# Eval("TenThuongHieu") %>'>
                            <asp:Image ID="imgLogo" runat="server"
                                ImageUrl='<%# Eval("Logo", "~/Images/Thuonghieu/{0}") %>'
                                AlternateText='<%# Eval("TenThuongHieu") %>'
                                CssClass="img-fluid"
                                Style="height: 30px; object-fit: contain;" />
                        </asp:HyperLink>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>

        <div class="bg-white rounded p-3 mb-4 shadow-sm border">
            <div class="d-flex justify-content-between align-items-center border-bottom pb-2 mb-3">
                <h5 class="fw-bold mb-0 text-uppercase text-dark">Danh Mục Sản Phẩm</h5>
                <a href="Default.aspx" class="text-primary text-decoration-none small">Bỏ lọc / Xem tất cả</a>
            </div>
            <div class="row text-center g-2">
                <asp:Repeater ID="rptDanhMuc" runat="server">
                    <ItemTemplate>
                        <div class="col-6 col-md-2">
                            <asp:HyperLink ID="lnkDanhMuc" runat="server"
                                NavigateUrl='<%# "~/Default.aspx?danhmuc=" + Eval("MaDanhMuc") %>'
                                CssClass="text-decoration-none text-dark d-block p-2 border rounded bg-light h-100">
                                <asp:Image ID="imgDanhMuc" runat="server"
                                    ImageUrl='<%# Eval("HinhAnh", "~/Images/Danhmuc/{0}") %>'
                                    AlternateText='<%# Eval("TenDanhMuc") %>'
                                    CssClass="rounded mb-2 w-100"
                                    Style="height: 70px; object-fit: cover;" />
                                <div class="fw-semibold small"><%# Eval("TenDanhMuc") %></div>
                            </asp:HyperLink>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>

        <asp:Panel ID="pnlKhuyenMai" runat="server" CssClass="hot-sale-section bg-danger rounded p-3 mb-4 shadow-sm">
            <div class="d-flex justify-content-between align-items-center mb-3 px-2">
                <h3 class="text-white fw-bold mb-0 text-uppercase">
                    <i class="bi bi-lightning-charge-fill text-warning"></i>Khuyến Mãi Hot
                </h3>
                <a href="Default.aspx" class="text-white text-decoration-none border border-white rounded px-3 py-1 bg-white bg-opacity-25">Xem tất cả <i class="bi bi-chevron-right"></i>
                </a>
            </div>

            <div class="row row-cols-2 row-cols-md-4 g-3">
                <asp:Repeater ID="rptKhuyenMai" runat="server">
                    <ItemTemplate>
                        <div class="col">
                            <div class="card h-100 product-card border-0">
                                <div class="badge bg-danger position-absolute top-0 start-0 m-2">
                                    Giảm <%# Eval("PhanTramGiam") %>%
                               
                                </div>
                                <a href='<%# "ChiTietSanPham.aspx?id=" + Eval("MaSanPham") %>'>
                                    <img src='<%# Eval("AnhDaiDien", "/Images/Sanpham/{0}") %>' class="card-img-top p-3" style="height: 200px; object-fit: contain;" alt='<%# Eval("TenSanPham") %>'>
                                </a>
                                <div class="card-body pt-0">
                                    <a href='<%# "ChiTietSanPham.aspx?id=" + Eval("MaSanPham") %>' class="text-decoration-none text-dark">
                                        <h5 class="card-title product-title fs-6"><%# Eval("TenSanPham") %></h5>
                                    </a>
                                    <div class="product-price">
                                        <span class="text-danger fw-bold fs-5"><%# Eval("GiaKhuyenMai", "{0:N0}đ") %></span>
                                        <br />
                                        <span class="text-decoration-line-through text-muted small"><%# Eval("GiaGoc", "{0:N0}đ") %></span>
                                    </div>
                                </div>
                                <div class="card-footer bg-white border-0 pt-0">
                                    <a href='<%# "ChiTietSanPham.aspx?id=" + Eval("MaSanPham") %>' class="btn btn-outline-danger w-100">Mua ngay</a>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </asp:Panel>

        <asp:Repeater ID="rptDanhMucSanPham" runat="server" OnItemDataBound="rptDanhMucSanPham_ItemDataBound">
            <ItemTemplate>
                <div class="bg-white rounded p-3 mb-4 shadow-sm border">
                    <div class="d-flex justify-content-between align-items-center border-bottom pb-2 mb-3">
                        <h3 class="fw-bold mb-0 text-uppercase text-dark"><%# Eval("TenDanhMuc") %></h3>
                        <a href='<%# "Default.aspx?danhmuc=" + Eval("MaDanhMuc") %>' class="text-primary text-decoration-none">Xem tất cả <i class="bi bi-chevron-right"></i>
                        </a>
                    </div>

                    <asp:HiddenField ID="hfMaDanhMuc" runat="server" Value='<%# Eval("MaDanhMuc") %>' />

                    <div class="row row-cols-2 row-cols-md-4 g-3">
                        <asp:Repeater ID="rptSanPhamTheoDanhMuc" runat="server">
                            <ItemTemplate>
                                <div class="col">
                                    <div class="card h-100 product-card shadow-sm border-light">
                                        <a href='<%# "ChiTietSanPham.aspx?id=" + Eval("MaSanPham") %>'>
                                            <img src='<%# Eval("AnhDaiDien", "Images/Sanpham/{0}") %>' class="card-img-top p-3" style="height: 200px; object-fit: contain;" alt='<%# Eval("TenSanPham") %>'>
                                        </a>
                                        <div class="card-body pt-0">
                                            <a href='<%# "ChiTietSanPham.aspx?id=" + Eval("MaSanPham") %>' class="text-decoration-none text-dark">
                                                <h5 class="card-title product-title fs-6"><%# Eval("TenSanPham") %></h5>
                                            </a>
                                            <div class="product-price">
                                                <span class="text-danger fw-bold fs-5"><%# Eval("GiaHienThi", "{0:N0}đ") %></span>
                                                <asp:Panel ID="pnlGiaGoc" runat="server" Visible='<%# Eval("GiaKhuyenMai") != DBNull.Value && Convert.ToDecimal(Eval("GiaKhuyenMai")) < Convert.ToDecimal(Eval("GiaGoc")) %>' CssClass="d-inline ms-1">
                                                    <span class="text-decoration-line-through text-muted small"><%# Eval("GiaGoc", "{0:N0}đ") %></span>
                                                </asp:Panel>
                                            </div>
                                            <div class="mt-2 text-muted" style="font-size: 0.85rem;">
                                                <span class="d-inline-block border bg-light rounded px-1 me-1 mb-1"><i class="bi bi-cpu"></i><%# Eval("CPU") %></span>
                                                <span class="d-inline-block border bg-light rounded px-1 me-1 mb-1"><i class="bi bi-memory"></i><%# Eval("RAM") %></span>
                                                <span class="d-inline-block border bg-light rounded px-1 mb-1"><i class="bi bi-gpu-card"></i><%# Eval("CardDoHoa") %></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>

    </main>

</asp:Content>
