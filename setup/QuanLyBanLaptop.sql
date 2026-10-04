CREATE DATABASE QuanLyBanLaptop
GO
USE QuanLyBanLaptop
GO

-- =============================================
-- 1. Bảng tblUser
-- =============================================
CREATE TABLE tblUser (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    Username VARCHAR(50) NOT NULL UNIQUE,
    Password VARCHAR(255) NOT NULL,
    Fullname NVARCHAR(100),
    Address NVARCHAR(255),
    Status INT,
    Role INT,
    Avatar VARCHAR(255),
    Email VARCHAR(100),
    Phone VARCHAR(15)
);
GO

-- =============================================
-- 2. Bảng DanhMuc
-- =============================================
CREATE TABLE tblDanhMuc (
    MaDanhMuc INT IDENTITY(1,1) PRIMARY KEY,      
    TenDanhMuc NVARCHAR(100) NOT NULL,            
    MoTa NVARCHAR(500),                           
    HinhAnh VARCHAR(255),                         
    TrangThai INT                       
);
GO

-- =============================================
-- 3. Bảng ThuongHieu
-- =============================================
CREATE TABLE tblThuongHieu (
    MaThuongHieu INT IDENTITY(1,1) PRIMARY KEY,   
    TenThuongHieu NVARCHAR(100) NOT NULL,         
    Logo VARCHAR(255),                            
    MoTa NVARCHAR(500),                           
    TrangThai INT                    
);
GO

-- =============================================
-- 4. Bảng SanPham
-- =============================================
CREATE TABLE tblSanPham (
    MaSanPham INT IDENTITY(1,1) PRIMARY KEY,      
    TenSanPham NVARCHAR(200) NOT NULL,            
    MaDanhMuc INT FOREIGN KEY REFERENCES tblDanhMuc(MaDanhMuc),           
    MaThuongHieu INT FOREIGN KEY REFERENCES tblThuongHieu(MaThuongHieu), 
    GiaGoc DECIMAL(18, 0) NOT NULL,               
    GiaKhuyenMai DECIMAL(18, 0),                  
    SoLuongTon INT DEFAULT 0,                     
    MoTa NVARCHAR(MAX),                           
    AnhDaiDien VARCHAR(255),                      
    TrangThai INT                      
);
GO

-- =============================================
-- 5. Bảng ThongSoKyThuat
-- =============================================
CREATE TABLE tblThongSoKyThuat (
    MaThongSo INT IDENTITY(1,1) PRIMARY KEY,
    MaSanPham INT FOREIGN KEY REFERENCES tblSanPham(MaSanPham) ON DELETE CASCADE,
    CPU NVARCHAR(100),                            
    RAM NVARCHAR(50),                             
    OCung NVARCHAR(100),                          
    CardDoHoa NVARCHAR(100),                      
    ManHinh NVARCHAR(100),                        
    DoPhanGiai NVARCHAR(50),                      
    TanSoQuet NVARCHAR(50),                       
    HeDieuHanh NVARCHAR(50),                      
    TrongLuong NVARCHAR(50),                      
    Pin NVARCHAR(50),                             
    MauSac NVARCHAR(50)                           
);
GO

-- =============================================
-- 6. Bảng HinhAnhSanPham
-- =============================================
CREATE TABLE tblHinhAnhSanPham (
    MaHinhAnh INT IDENTITY(1,1) PRIMARY KEY,      
    MaSanPham INT FOREIGN KEY REFERENCES tblSanPham(MaSanPham) ON DELETE CASCADE, 
    DuongDanAnh VARCHAR(255) NOT NULL,            
    LaAnhChinh INT                     
);
GO

-- =============================================
-- 7. Bảng DonHang
-- =============================================
CREATE TABLE tblDonHang (
    MaDonHang INT IDENTITY(1,1) PRIMARY KEY,      
    UserID INT FOREIGN KEY REFERENCES tblUser(UserID), 
    HoTenNguoiNhan NVARCHAR(100) NOT NULL,        
    SoDienThoai VARCHAR(15) NOT NULL,             
    DiaChiGiaoHang NVARCHAR(255) NOT NULL,        
    TongTien DECIMAL(18, 0) NOT NULL,             
    TrangThai INT, 
    PhuongThucThanhToan NVARCHAR(50),             
    GhiChu NVARCHAR(500),                         
    NgayTao DATETIME            
);
GO

-- =============================================
-- 8. Bảng ChiTietDonHang
-- =============================================
CREATE TABLE tblChiTietDonHang (
    MaChiTietDonHang INT IDENTITY(1,1) PRIMARY KEY, 
    MaDonHang INT FOREIGN KEY REFERENCES tblDonHang(MaDonHang) ON DELETE CASCADE, 
    MaSanPham INT FOREIGN KEY REFERENCES tblSanPham(MaSanPham),                   
    SoLuong INT NOT NULL,                           
    DonGia DECIMAL(18, 0) NOT NULL                  
);
GO

-- =============================================
-- DỮ LIỆU MẪU (Đã chuẩn hóa ảnh)
-- =============================================

-- TÀI KHOẢN NGƯỜI DÙNG
INSERT INTO tblUser (Username, Password, Fullname, Address, Status, Role, Avatar, Email, Phone)
VALUES 
('admin', 'e10adc3949ba59abbe56e057f20f883e', N'Admin', NULL, 1, 1, 'default-avatar.png', NULL, '0912334354');
GO

-- DANH MỤC
INSERT INTO tblDanhMuc (TenDanhMuc, MoTa, HinhAnh, TrangThai)
VALUES 
(N'Laptop Gaming', N'Dòng laptop cấu hình khủng, card đồ họa rời mạnh mẽ và tản nhiệt tối ưu chuyên dụng cho game thủ.', 'dm_639265630936844336.png', 1),
(N'Laptop Học tập - Văn phòng', N'Thiết kế thanh lịch, pin bền bỉ, đáp ứng mượt mà các tác vụ Word, Excel, thuyết trình và làm việc hàng ngày.', 'dm_639265632340016231.png', 1),
(N'Laptop Đồ họa - Kỹ thuật', N'Màn hình chuẩn màu, CPU đa nhân và GPU chuyên dụng cho thiết kế 2D/3D, dựng phim, AutoCAD, Adobe.', 'dm_639265633307666013.png', 1),
(N'Laptop Mỏng nhẹ - Cao cấp', N'Kiểu dáng sang trọng, vỏ kim loại siêu mỏng nhẹ dưới 1.3kg, bảo mật cao dành cho doanh nhân hay di chuyển.', 'dm_639265634255602216.png', 1),
(N'Laptop AI - Thế hệ mới', N'Tích hợp vi xử lý NPU chuyên biệt hỗ trợ xử lý các tác vụ trí tuệ nhân tạo (AI) nhanh chóng và tiết kiệm pin.', 'dm_639265635002524290.png', 1),
(N'Laptop Sinh viên - Giá rẻ', N'Mức giá tiết kiệm, độ bền cao, cấu hình ổn định phục vụ tốt nhu cầu học online và giải trí cơ bản.', 'dm_639265631600224792.png', 1);
GO

-- THƯƠNG HIỆU
INSERT INTO tblThuongHieu (TenThuongHieu, Logo, MoTa, TrangThai)
VALUES 
(N'Apple (MacBook)', 'MacBook_Pro.svg.webp', N'Thương hiệu công nghệ hàng đầu từ Mỹ với các dòng MacBook Air và MacBook Pro sang trọng, hiệu năng đỉnh cao nhờ chip Apple Silicon và hệ điều hành macOS mượt mà.', 1),
(N'Dell', 'Dell_logo.svg.webp', N'Hãng máy tính Mỹ nổi tiếng với độ bền bỉ cao, linh kiện ổn định qua các dòng Dell Inspiron, Vostro, Latitude, XPS cao cấp và Alienware/G-Series chuyên game.', 1),
(N'HP', 'HP_logo_2012.svg', N'Thương hiệu lâu đời từ Mỹ với thiết kế hiện đại, thanh lịch và tính bảo mật cao, nổi bật với các dòng HP Pavilion, Envy, Spectre, ProBook và Victus/Omen.', 1),
(N'ASUS', 'AsusTek-black-logo.png', N'Tập đoàn công nghệ Đài Loan tiên phong về màn hình OLED và thiết kế sáng tạo, sở hữu các dòng Vivobook, Zenbook mỏng nhẹ cùng ROG và TUF Gaming danh tiếng.', 1),
(N'Lenovo', 'Lenovo_logo_2015.svg.webp', N'Thương hiệu laptop thị phần hàng đầu thế giới với bàn phím gõ êm ái và độ bền chuẩn quân đội, nổi bật với các dòng IdeaPad, Yoga, ThinkPad, LOQ và Legion.', 1),
(N'Acer', 'dm_639265609619735442.webp', N'Thương hiệu Đài Loan nổi bật với cấu hình trên giá thành cực tốt và hệ thống tản nhiệt mạnh mẽ, phổ biến với dòng Aspire, Swift và Nitro/Predator Gaming.', 1);
GO

-- SẢN PHẨM
INSERT INTO tblSanPham (TenSanPham, MaDanhMuc, MaThuongHieu, GiaGoc, GiaKhuyenMai, SoLuongTon, MoTa, AnhDaiDien, TrangThai)
VALUES 
(N'Apple MacBook Air M3 13 inch (8GB/256GB)', 4, 1, 27990000, 25490000, 15, N'MacBook Air M3 sở hữu thiết kế siêu mỏng nhẹ, thời lượng pin lên đến 18 giờ cùng hiệu năng vượt trội từ chip Apple M3 thế hệ mới.', 'sp_639267263109046505.webp', 1),
(N'Apple MacBook Pro 14 inch M3 Pro (18GB/512GB)', 3, 1, 49990000, 46990000, 8, N'Chiếc laptop chuyên nghiệp dành cho lập trình viên, dựng phim 4K/8K và thiết kế đồ họa nặng với màn hình Liquid Retina XDR 120Hz.', 'sp_639267262498104865.webp', 1),
(N'Dell XPS 13 9340 Intel Core Ultra 7 155H', 5, 2, 44990000, 41990000, 5, N'Tuyệt tác công nghệ từ Dell tích hợp vi xử lý Intel Core Ultra có nhân NPU AI chuyên biệt, thiết kế vỏ nhôm nguyên khối cắt CNC tinh xảo.', 'sp_639267261640066427.jpg', 1),
(N'Dell Inspiron 15 3520 i5 1235U (16GB/512GB)', 2, 2, 16490000, 14990000, 25, N'Mẫu laptop quốc dân cho dân văn phòng và kế toán với bàn phím Fullsize, màn hình 120Hz mượt mà cùng độ bền chuẩn Dell.', 'sp_639267259519850470.webp', 1),
(N'HP Pavilion 15 eg3093TU i5 1335U (16GB/512GB)', 2, 3, 18290000, NULL, 18, N'Thiết kế vỏ kim loại màu vàng Gold sang trọng, âm thanh B&O sống động, đáp ứng hoàn hảo công việc văn phòng và giải trí.', 'sp_639267258873975166.jpg', 1),
(N'HP Gaming Victus 16 r0129TX i7 13700H RTX 4060', 1, 3, 28990000, 24990000, 12, N'Laptop gaming mang phong cách tối giản thanh lịch, trang bị cấu hình khủng chiến mượt mọi tựa game AAA và làm đồ họa kỹ thuật.', 'sp_639267258193523720.webp', 1),
(N'ASUS ROG Strix G16 G614JU i7 13650HX RTX 4050', 1, 4, 36990000, 32490000, 10, N'Vũ khí tối thượng cho game thủ eSports với hệ thống tản nhiệt 3 quạt keo kim loại lỏng và dải LED RGB Aura Sync cực chất.', 'sp_639267248592469760.webp', 1),
(N'ASUS Vivobook Go 15 E1504FA R5 7520U (16GB/512GB)', 6, 4, 12990000, 10990000, 30, N'Lựa chọn số 1 cho tân sinh viên với mức giá cực kỳ tiết kiệm nhưng sở hữu sẵn 16GB RAM, bản lề mở 180 độ và độ bền chuẩn quân đội.', 'sp_639267246296456323.webp', 1),
(N'Lenovo Legion Slim 5 16AHP9 R7 8845HS RTX 4060', 1, 5, 39990000, 35990000, 7, N'Sự kết hợp hoàn hảo giữa hiệu năng gaming đỉnh cao, chip Ryzen tích hợp AI và màn hình chuẩn màu 100% sRGB 165Hz.', 'sp_639267245130204339.jpg', 1),
(N'Acer Gaming Nitro 5 Tiger AN515 i5 12500H RTX 3050', 1, 6, 23990000, 19490000, 20, N'Ông vua laptop gaming quốc dân trong tầm giá dưới 20 triệu, tản nhiệt CoolBoost 2 quạt mạnh mẽ cùng bàn phím RGB 4 vùng.', 'sp_639267239155738829.jpg', 1);
GO

-- THÔNG SỐ KỸ THUẬT
INSERT INTO tblThongSoKyThuat (MaSanPham, CPU, RAM, OCung, CardDoHoa, ManHinh, DoPhanGiai, TanSoQuet, HeDieuHanh, TrongLuong, Pin, MauSac)
VALUES
(1, N'Apple M3 8-Core', N'8GB Unified', N'256GB SSD', N'8-core GPU', N'13.6 inch Liquid Retina', N'2560 x 1664', N'60Hz', N'macOS Sonoma', N'1.24 kg', N'52.6 Wh', N'Xám Space Gray'),
(2, N'Apple M3 Pro 11-Core', N'18GB Unified', N'512GB SSD', N'14-core GPU', N'14.2 inch Liquid Retina XDR', N'3024 x 1964', N'120Hz ProMotion', N'macOS Sonoma', N'1.61 kg', N'72.4 Wh', N'Đen Space Black'),
(3, N'Intel Core Ultra 7 155H', N'16GB LPDDR5X', N'512GB SSD NVMe', N'Intel Arc Graphics', N'13.4 inch IPS', N'1920 x 1200 (FHD+)', N'120Hz', N'Windows 11 Home', N'1.19 kg', N'55 Wh', N'Bạc Platinum'),
(4, N'Intel Core i5-1235U', N'16GB DDR4', N'512GB SSD NVMe', N'Intel Iris Xe Graphics', N'15.6 inch WVA', N'1920 x 1080 (FHD)', N'120Hz', N'Windows 11 + Office HS', N'1.65 kg', N'3 Cell 41Wh', N'Đen Carbon'),
(5, N'Intel Core i5-1335U', N'16GB DDR4', N'512GB SSD PCIe', N'Intel Iris Xe Graphics', N'15.6 inch IPS BrightView', N'1920 x 1080 (FHD)', N'60Hz', N'Windows 11 Home', N'1.74 kg', N'3 Cell 41Wh', N'Vàng Warm Gold'),
(6, N'Intel Core i7-13700H', N'16GB DDR5', N'512GB SSD Gen4', N'NVIDIA RTX 4060 8GB', N'16.1 inch IPS', N'1920 x 1080 (FHD)', N'144Hz', N'Windows 11 Home', N'2.31 kg', N'4 Cell 70Wh', N'Đen Mica Silver'),
(7, N'Intel Core i7-13650HX', N'16GB DDR5', N'512GB SSD PCIe 4.0', N'NVIDIA RTX 4050 6GB', N'16 inch IPS ROG Nebula', N'1920 x 1200 (FHD+)', N'165Hz', N'Windows 11 Home', N'2.50 kg', N'4 Cell 90Wh', N'Xám Eclipse Gray'),
(8, N'AMD Ryzen 5 7520U', N'16GB LPDDR5', N'512GB SSD M.2', N'AMD Radeon Graphics', N'15.6 inch Anti-Glare', N'1920 x 1080 (FHD)', N'60Hz', N'Windows 11 Home', N'1.63 kg', N'3 Cell 42Wh', N'Bạc Cool Silver'),
(9, N'AMD Ryzen 7 8845HS', N'16GB DDR5 5600MHz', N'512GB SSD PCIe 4.0', N'NVIDIA RTX 4060 8GB', N'16 inch IPS 100% sRGB', N'2560 x 1600 (WQXGA)', N'165Hz', N'Windows 11 Home', N'2.30 kg', N'4 Cell 80Wh', N'Xám Luna Grey'),
(10, N'Intel Core i5-12500H', N'16GB DDR4', N'512GB SSD NVMe', N'NVIDIA RTX 3050 4GB', N'15.6 inch IPS SlimBezel', N'1920 x 1080 (FHD)', N'144Hz', N'Windows 11 Home', N'2.50 kg', N'4 Cell 57.5Wh', N'Đen Obsidian Black');
GO

-- ALBUM ẢNH PHỤ SẢN PHẨM
INSERT INTO tblHinhAnhSanPham (MaSanPham, DuongDanAnh, LaAnhChinh)
VALUES 
(1, 'album_1_639267263109166495_1.webp', 0),
(1, 'album_1_639267263109196166_2.webp', 0),
(2, 'album_2_639267262498234391_1.webp', 0),
(2, 'album_2_639267262498254376_2.webp', 0),
(3, 'album_3_639267261640238354_1.webp', 0),
(3, 'album_3_639267261640258330_2.jpg', 0),
(4, 'album_4_639267259519982144_1.webp', 0),
(4, 'album_4_639267259520007967_2.webp', 0),
(5, 'album_5_639267258875157092_1.jpg', 0),
(5, 'album_5_639267258875177072_2.jpg', 0),
(6, 'album_6_639267258194846865_1.webp', 0),
(6, 'album_6_639267258194886885_2.webp', 0),
(7, 'album_7_639267248592585679_1.webp', 0),
(7, 'album_7_639267248592605664_2.webp', 0),
(8, 'album_8_639267246296581481_1.webp', 0),
(8, 'album_8_639267246296607232_2.webp', 0),
(9, 'album_9_639267245130342213_1.jpg', 0),
(9, 'album_9_639267245130368935_2.jpg', 0),
(10, 'album_10_639267239155884888_1.jpg', 0),
(10, 'album_10_639267239155912468_2.jpg', 0);
GO
