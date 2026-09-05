<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebBanLaptop.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    
    <div class="carousel" id="homeCarousel">
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="https://images.unsplash.com/photo-1593640408182-31c70c8268f5?auto=format&fit=crop&w=1200&h=400&q=80" alt="Khuyến mãi 1" />
            </div>
            <div class="carousel-item">
                <img src="https://images.unsplash.com/photo-1603302576837-37561b2e2302?auto=format&fit=crop&w=1200&h=400&q=80" alt="Khuyến mãi 2" />
            </div>
            <div class="carousel-item">
                <img src="https://images.unsplash.com/photo-1525547719571-a2d4ac8945e2?auto=format&fit=crop&w=1200&h=400&q=80" alt="Khuyến mãi 3" />
            </div>
        </div>
        <div class="carousel-indicators">
            <button type="button" class="active" data-slide="0"></button>
            <button type="button" data-slide="1"></button>
            <button type="button" data-slide="2"></button>
        </div>
        <button class="carousel-control prev" type="button" id="prevBtn"><i class="bi bi-chevron-left"></i></button>
        <button class="carousel-control next" type="button" id="nextBtn"><i class="bi bi-chevron-right"></i></button>
    </div>

    <div class="brand-grid">
        <a href="#" class="brand-box">
            <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/1/1b/MacBook_Pro.svg/1280px-MacBook_Pro.svg.png" alt="MacBook" />
        </a>
        <a href="#" class="brand-box">
            <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/a/ae/Dell_logo.svg/1280px-Dell_logo.svg.png" alt="Dell" />
        </a>
        <a href="#" class="brand-box">
            <img src="https://upload.wikimedia.org/wikipedia/commons/a/ad/HP_logo_2012.svg" alt="HP" />
        </a>
        <a href="#" class="brand-box">
            <img src="https://upload.wikimedia.org/wikipedia/commons/d/de/AsusTek-black-logo.png" alt="Asus" />
        </a>
        <a href="#" class="brand-box">
            <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/b/b8/Lenovo_logo_2015.svg/1280px-Lenovo_logo_2015.svg.png" alt="Lenovo" />
        </a>
        <a href="#" class="brand-box">
            <img src="https://inviva.vn/wp-content/uploads/2026/05/logo-acer-vector-02.svg" alt="Acer" />
        </a>
    </div>

    <div class="hot-sale-section">
        <div class="section-header">
            <h3><i class="bi bi-lightning-charge-fill icon-warning"></i> Khuyến Mãi Hot</h3>
            <a href="#" class="view-all">Xem tất cả <i class="bi bi-chevron-right"></i></a>
        </div>
        
        <div class="product-grid">
            <div class="product-card">
                <div class="badge-discount">Giảm 15%</div>
                <a href="#">
                    <img src="https://images.unsplash.com/photo-1517336714731-489689fd1ca8?auto=format&fit=crop&w=300&h=300&q=80" alt="MacBook Air M1" />
                </a>
                <div class="card-body">
                    <a href="#"><h5 class="product-title">MacBook Air 13" 2020 M1 256GB</h5></a>
                    <div class="product-price">
                        <span class="price-current">18.990.000đ</span>
                        <span class="price-old">22.990.000đ</span>
                    </div>
                </div>
                <div class="card-footer">
                    <a href="#" class="btn-buy">Mua ngay</a>
                </div>
            </div>

            <div class="product-card">
                <div class="badge-discount">Giảm 20%</div>
                <a href="#">
                    <img src="https://images.unsplash.com/photo-1593642632823-8f785ba67e45?auto=format&fit=crop&w=300&h=300&q=80" alt="Dell XPS 13" />
                </a>
                <div class="card-body">
                    <a href="#"><h5 class="product-title">Laptop Dell XPS 13 9315</h5></a>
                    <div class="product-price">
                        <span class="price-current">25.490.000đ</span>
                        <span class="price-old">31.990.000đ</span>
                    </div>
                </div>
                <div class="card-footer">
                    <a href="#" class="btn-buy">Mua ngay</a>
                </div>
            </div>

            <div class="product-card">
                <div class="badge-discount">Giảm 10%</div>
                <a href="#">
                    <img src="https://images.unsplash.com/photo-1603302576837-37561b2e2302?auto=format&fit=crop&w=300&h=300&q=80" alt="Asus TUF" />
                </a>
                <div class="card-body">
                    <a href="#"><h5 class="product-title">Laptop Asus TUF Gaming F15</h5></a>
                    <div class="product-price">
                        <span class="price-current">20.990.000đ</span>
                        <span class="price-old">23.490.000đ</span>
                    </div>
                </div>
                <div class="card-footer">
                    <a href="#" class="btn-buy">Mua ngay</a>
                </div>
            </div>

            <div class="product-card">
                <div class="badge-discount">Giảm 5%</div>
                <a href="#">
                    <img src="https://images.unsplash.com/photo-1525547719571-a2d4ac8945e2?auto=format&fit=crop&w=300&h=300&q=80" alt="Lenovo IdeaPad" />
                </a>
                <div class="card-body">
                    <a href="#"><h5 class="product-title">Laptop Lenovo IdeaPad Slim 5</h5></a>
                    <div class="product-price">
                        <span class="price-current">16.490.000đ</span>
                        <span class="price-old">17.490.000đ</span>
                    </div>
                </div>
                <div class="card-footer">
                    <a href="#" class="btn-buy">Mua ngay</a>
                </div>
            </div>
        </div>
    </div>

    <div class="gaming-section">
        <div class="section-header-gaming">
            <h3>Laptop Gaming</h3>
            <a href="#" class="view-all-gaming">Xem tất cả <i class="bi bi-chevron-right"></i></a>
        </div>
        
        <div class="product-grid">
            <div class="product-card">
                <img src="https://images.unsplash.com/photo-1598440947619-2c35fc9aa908?auto=format&fit=crop&w=300&h=300&q=80" alt="Acer Nitro 5" />
                <div class="card-body">
                    <h5 class="product-title">Laptop Acer Nitro 5 Tiger AN515-58</h5>
                    <div class="product-price">
                        <span class="price-current">23.990.000đ</span>
                    </div>
                    <div class="specs">
                        <span><i class="bi bi-cpu"></i> i5 12500H</span>
                        <span><i class="bi bi-memory"></i> 8GB</span>
                        <span><i class="bi bi-gpu-card"></i> RTX 3050</span>
                    </div>
                </div>
            </div>

            <div class="product-card">
                <img src="https://images.unsplash.com/photo-1593642632823-8f785ba67e45?auto=format&fit=crop&w=300&h=300&q=80" alt="MSI GF63" />
                <div class="card-body">
                    <h5 class="product-title">Laptop MSI Gaming Thin GF63 12VE</h5>
                    <div class="product-price">
                        <span class="price-current">19.990.000đ</span>
                    </div>
                    <div class="specs">
                        <span><i class="bi bi-cpu"></i> i5 12450H</span>
                        <span><i class="bi bi-memory"></i> 8GB</span>
                        <span><i class="bi bi-gpu-card"></i> RTX 4050</span>
                    </div>
                </div>
            </div>

            <div class="product-card">
                <img src="https://images.unsplash.com/photo-1603302576837-37561b2e2302?auto=format&fit=crop&w=300&h=300&q=80" alt="Lenovo Legion 5" />
                <div class="card-body">
                    <h5 class="product-title">Laptop Lenovo Legion 5 15IAH7</h5>
                    <div class="product-price">
                        <span class="price-current">28.990.000đ</span>
                    </div>
                    <div class="specs">
                        <span><i class="bi bi-cpu"></i> i5 12500H</span>
                        <span><i class="bi bi-memory"></i> 16GB</span>
                        <span><i class="bi bi-gpu-card"></i> RTX 3050Ti</span>
                    </div>
                </div>
            </div>

            <div class="product-card">
                <img src="https://images.unsplash.com/photo-1525547719571-a2d4ac8945e2?auto=format&fit=crop&w=300&h=300&q=80" alt="HP Victus 15" />
                <div class="card-body">
                    <h5 class="product-title">Laptop HP Gaming Victus 15-fa0155TX</h5>
                    <div class="product-price">
                        <span class="price-current">18.490.000đ</span>
                    </div>
                    <div class="specs">
                        <span><i class="bi bi-cpu"></i> i5 12450H</span>
                        <span><i class="bi bi-memory"></i> 8GB</span>
                        <span><i class="bi bi-gpu-card"></i> RTX 3050</span>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
