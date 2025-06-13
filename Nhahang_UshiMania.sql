create database Nhahang
use Nhahang
go 

-- Bảng: Khu vực
CREATE TABLE Khu_vuc (
    Ma_khu_vuc INT PRIMARY KEY,
    Ten_khu_vuc VARCHAR(50) NOT NULL UNIQUE,
    Mo_ta TEXT,
    Thoi_gian_tao DATETIME DEFAULT GETDATE(),
    Thoi_gian_cap_nhat DATETIME DEFAULT GETDATE()
);

-- Bảng: Bàn ăn
CREATE TABLE Ban_an (
    Ma_ban CHAR(5) PRIMARY KEY,
    Ma_khu_vuc INT FOREIGN KEY REFERENCES Khu_vuc(Ma_khu_vuc),
    Trang_thai VARCHAR(20) DEFAULT 'AVAILABLE',
    Suc_chua INT NOT NULL,
    Thoi_gian_tao DATETIME DEFAULT GETDATE(),
    Thoi_gian_cap_nhat DATETIME DEFAULT GETDATE()
);

-- Bảng: Khuyến mãi
CREATE TABLE Khuyen_mai (
    Ma_khuyen_mai CHAR(10) PRIMARY KEY,
    Ten_khuyen_mai VARCHAR(50) NOT NULL,
    Mo_ta TEXT,
    Hinh_anh VARCHAR(255),
    Ty_le_khuyen_mai DECIMAL(10,2) NOT NULL,
    Gia_tri_don_hang_toi_thieu DECIMAL(10,2) DEFAULT 0,
    Thoi_gian_tao DATETIME DEFAULT GETDATE(),
    Thoi_gian_cap_nhat DATETIME DEFAULT GETDATE()
);

-- Bảng: Chi tiết khuyến mãi
CREATE TABLE Chi_tiet_khuyen_mai (
    Ma_khuyen_mai CHAR(10),
    Ngay_bat_dau DATETIME,
    Ngay_ket_thuc DATETIME,
    So_luot_dung INT NOT NULL,
    So_luot_da_dung INT DEFAULT 0,
    Trang_thai BIT,
    PRIMARY KEY (Ma_khuyen_mai, Ngay_bat_dau),
    FOREIGN KEY (Ma_khuyen_mai) REFERENCES Khuyen_mai(Ma_khuyen_mai)
);

-- Bảng: Chức vụ
CREATE TABLE Chuc_vu (
    Ma_chuc_vu CHAR(10) PRIMARY KEY,
    Ten_chuc_vu VARCHAR(50) NOT NULL,
    Thoi_gian_tao DATETIME DEFAULT GETDATE(),
    Thoi_gian_cap_nhat DATETIME DEFAULT GETDATE()
);

-- Bảng: Địa chỉ
CREATE TABLE Dia_chi (
    Ma_dia_chi CHAR(10) PRIMARY KEY,
    Ten_dia_chi VARCHAR(50) NOT NULL,
    Thoi_gian_tao DATETIME DEFAULT GETDATE(),
    Thoi_gian_cap_nhat DATETIME DEFAULT GETDATE()
);

-- Bảng: Hạng thành viên
CREATE TABLE Hang_thanh_vien (
    Ma_hang_thanh_vien CHAR(10) PRIMARY KEY,
    Ten_hang_thanh_vien VARCHAR(50) NOT NULL,
    Mo_ta_uu_dai TEXT,
    Muc_nang_hang DECIMAL(10,2),
    Thoi_gian_tao DATETIME DEFAULT GETDATE(),
    Thoi_gian_cap_nhat DATETIME DEFAULT GETDATE()
);

-- Bảng: Khách hàng
CREATE TABLE Khach_hang (
    Ma_khach_hang INT PRIMARY KEY,
    Ten_khach_hang VARCHAR(50) NOT NULL,
    So_dien_thoai CHAR(20) UNIQUE,
    Thoi_gian_tao DATETIME DEFAULT GETDATE(),
    Thoi_gian_cap_nhat DATETIME DEFAULT GETDATE()
);

-- Bảng: Thành viên
CREATE TABLE Thanh_vien (
    Ma_thanh_vien INT PRIMARY KEY,
    Ma_khach_hang INT FOREIGN KEY REFERENCES Khach_hang(Ma_khach_hang),
    Ma_hang_thanh_vien CHAR(10) FOREIGN KEY REFERENCES Hang_thanh_vien(Ma_hang_thanh_vien),
    Diem_tich_luy DECIMAL(10,2) DEFAULT 0,
    Email CHAR(100) UNIQUE,
    Trang_thai BIT,
    Thoi_gian_tao DATETIME DEFAULT GETDATE(),
    Thoi_gian_cap_nhat DATETIME DEFAULT GETDATE()
);

-- Bảng: Nhân viên
CREATE TABLE Nhan_vien (
    Ma_nhan_vien INT PRIMARY KEY,
    Ten_nhan_vien VARCHAR(50) NOT NULL,
    So_dien_thoai CHAR(20) UNIQUE,
    CCCD CHAR(10) UNIQUE,
    Email CHAR(100) UNIQUE,
    Mat_khau VARCHAR(50) NOT NULL,
    Ma_chuc_vu CHAR(10) FOREIGN KEY REFERENCES Chuc_vu(Ma_chuc_vu),
    Ma_dia_chi CHAR(10) FOREIGN KEY REFERENCES Dia_chi(Ma_dia_chi),
    Thoi_gian_tao DATETIME DEFAULT GETDATE(),
    Thoi_gian_cap_nhat DATETIME DEFAULT GETDATE()
);

-- Bảng: Phương thức thanh toán
CREATE TABLE Phuong_thuc_thanh_toan (
    Ma_phuong_thuc_thanh_toan INT PRIMARY KEY,
    Ten_phuong_thuc_thanh_toan VARCHAR(50) NOT NULL,
    Trang_thai BIT DEFAULT 1,
    Thoi_gian_tao DATETIME DEFAULT GETDATE(),
    Thoi_gian_cap_nhat DATETIME DEFAULT GETDATE()
);

-- Bảng: Hóa đơn
CREATE TABLE Hoa_don (
    Ma_hoa_don CHAR(10) PRIMARY KEY,
    Ma_khach_hang INT NOT NULL,
    Ma_nhan_vien INT FOREIGN KEY REFERENCES Nhan_vien(Ma_nhan_vien),
    Ma_phuong_thuc_thanh_toan INT FOREIGN KEY REFERENCES Phuong_thuc_thanh_toan(Ma_phuong_thuc_thanh_toan),
    Ma_ban CHAR(5) FOREIGN KEY REFERENCES Ban_an(Ma_ban),
    Ma_khuyen_mai CHAR(10) FOREIGN KEY REFERENCES Khuyen_mai(Ma_khuyen_mai),
    Tinh_trang BIT DEFAULT 0,
    Tong_tien DECIMAL(10,2) DEFAULT 0,
    VAT DECIMAL(10,2) DEFAULT 0,
    Thoi_gian_tao DATETIME DEFAULT GETDATE(),
    Thoi_gian_cap_nhat DATETIME DEFAULT GETDATE()
);

-- Bảng: Danh mục món ăn
CREATE TABLE Danh_muc_mon_an (
    Ma_danh_muc CHAR(10) PRIMARY KEY,
    Ten_danh_muc VARCHAR(50) NOT NULL,
    Trang_thai BIT,
    Thoi_gian_tao DATETIME DEFAULT GETDATE(),
    Thoi_gian_cap_nhat DATETIME DEFAULT GETDATE()
);

-- Bảng: Món ăn
CREATE TABLE Mon_an (
    Ma_mon_an CHAR(10) PRIMARY KEY,
    Ten_mon_an VARCHAR(50) NOT NULL,
    Mo_ta TEXT,
    Don_gia DECIMAL(10,2) DEFAULT 0,
    Hinh_anh VARCHAR(50),
    Trang_thai BIT DEFAULT 1, -- 1: đang bán, 0: ngừng bán
    Kieu_mon BIT DEFAULT 0,   -- 0: món đơn, 1: combo
    Ma_danh_muc CHAR(10) FOREIGN KEY REFERENCES Danh_muc_mon_an(Ma_danh_muc),
    Thoi_gian_tao DATETIME DEFAULT GETDATE(),
    Thoi_gian_cap_nhat DATETIME DEFAULT GETDATE()
);

--Bảng: Combo_chi_tiet (chi tiết món combo)
CREATE TABLE Combo_chi_tiet (
    Ma_combo CHAR(10),          -- Mã món combo
    Ma_mon_don CHAR(10),        -- Mã món đơn trong combo
    So_luong INT DEFAULT 1,
    PRIMARY KEY (Ma_combo, Ma_mon_don),
    FOREIGN KEY (Ma_combo) REFERENCES Mon_an(Ma_mon_an),
    FOREIGN KEY (Ma_mon_don) REFERENCES Mon_an(Ma_mon_an)
);

-- Bảng: Chi tiết hóa đơn
CREATE TABLE Chi_tiet_hoa_don (
    Ma_hoa_don CHAR(10),
    Ma_mon_an CHAR(10),
    So_luong INT,
    Trang_thai BIT DEFAULT 0,
    Ghi_chu TEXT,
    PRIMARY KEY (Ma_hoa_don, Ma_mon_an),
    FOREIGN KEY (Ma_hoa_don) REFERENCES Hoa_don(Ma_hoa_don),
    FOREIGN KEY (Ma_mon_an) REFERENCES Mon_an(Ma_mon_an)
);

--INSERT BẢNG KHU VỰC
INSERT INTO Khu_vuc (Ma_khu_vuc, Ten_khu_vuc, Mo_ta)
VALUES 
(1, 'Khu A', 'Khu vực ghế đơn & bàn 2 người (Dành cho cặp đôi / khách lẻ)'),
(2, 'Khu B', 'Khu vực bàn nhóm 4–6 người, phù hợp gia đình hoặc nhóm bạn'),
(3, 'Khu C', 'Khu vực bàn dài hoặc Teppanyaki, dành cho trải nghiệm món nướng tại bàn'),
(4, 'Khu D', 'Phòng VIP riêng, phù hợp cho họp mặt, tiếp khách hoặc không gian riêng tư');

--INSERT BẢNG BÀN ĂN
INSERT INTO Ban_an (Ma_ban, Ma_khu_vuc, Trang_thai, Suc_chua)
VALUES 
('B001', 1, 'AVAILABLE', 2),
('B002', 1, 'IN USE', 2),
('B003', 2, 'AVAILABLE', 4),
('B004', 2, 'RESERVED', 6),
('B005', 4, 'AVAILABLE', 8);

--INSERT BẢNG KHUYẾN MÃI
INSERT INTO Khuyen_mai (Ma_khuyen_mai, Ten_khuyen_mai, Mo_ta, Hinh_anh, Ty_le_khuyen_mai, Gia_tri_don_hang_toi_thieu)
VALUES
('KM001', 'Giảm 10% cho đơn từ 200k', 'Khuyến mãi cho khách hàng mới', 'km1.jpg', 10.00, 200000),
('KM002', 'Giảm 20% cuối tuần', 'Áp dụng từ thứ 6 đến CN hàng tuần', 'km2.jpg', 20.00, 0),
('KM003', 'Ưu đãi sinh nhật', 'Giảm 30% trong tuần sinh nhật khách hàng', 'km3.jpg', 30.00, 100000),
('KM004', 'Combo tiết kiệm', 'Mua 2 tặng 1 cho set ăn trưa', 'km4.jpg', 33.33, 150000),
('KM005', 'Ưu đãi VIP', 'Khách hàng VIP giảm 25% mỗi lần ăn', 'km5.jpg', 25.00, 0);

----INSERT BẢNG CHI TIẾT KHUYẾN MÃI
INSERT INTO Chi_tiet_khuyen_mai (Ma_khuyen_mai, Ngay_bat_dau, Ngay_ket_thuc, So_luot_dung, So_luot_da_dung, Trang_thai)
VALUES
('KM001', '2025-06-01', '2025-06-30', 100, 10, 1),
('KM002', '2025-06-07', '2025-06-09', 200, 50, 1),
('KM003', '2025-06-10', '2025-06-16', 50, 5, 1),
('KM004', '2025-06-01', '2025-06-15', 150, 80, 1),
('KM005', '2025-06-01', '2025-12-31', 9999, 120, 1);

-- INSERT BẢNG Chuc_vu
INSERT INTO Chuc_vu (Ma_chuc_vu, Ten_chuc_vu)
VALUES
('CV001', 'Quản lý nhà hàng'),
('CV002', 'Nhân viên phục vụ'),
('CV003', 'Nhân viên thu ngân'),
('CV004', 'Nhân viên bếp'),
('CV005', 'Quản lý bếp');

-- INSERT BẢNG Dia_chi
INSERT INTO Dia_chi (Ma_dia_chi, Ten_dia_chi)
VALUES
('DC001', 'Thanh Xuân, Hà Nội'),
('DC002', 'Đống Đa, Hà Nội'),
('DC003', 'Long Biên, Hà Nội'),
('DC004', 'Nam Từ Liêm, Hà Nội'),
('DC005', 'Cầu Giấy, Hà Nội');

-- INSERT BẢNG Hang_thanh_vien
INSERT INTO Hang_thanh_vien (Ma_hang_thanh_vien, Ten_hang_thanh_vien, Mo_ta_uu_dai, Muc_nang_hang)
VALUES
('HV001', 'Thành viên Đồng', 'Tích lũy điểm khi mua hàng', 0),
('HV002', 'Thành viên Bạc', 'Giảm 5% cho mỗi hóa đơn từ 500k', 500000),
('HV003', 'Thành viên Vàng', 'Giảm 10%, ưu tiên đặt bàn', 2000000),
('HV004', 'Thành viên Bạch Kim', 'Giảm 15%, tặng món khai vị miễn phí', 5000000),
('HV005', 'Thành viên Kim Cương', 'Giảm 20%, miễn phí nước suốt bữa ăn', 10000000);

-- INSERT BẢNG Khach_hang
INSERT INTO Khach_hang (Ma_khach_hang, Ten_khach_hang, So_dien_thoai)
VALUES
(1, 'Nguyễn Văn A', '0900000001'),
(2, 'Trần Thị B', '0900000002'),
(3, 'Lê Văn C', '0900000003'),
(4, 'Phạm Thị D', '0900000004'),
(5, 'Hoàng Văn E', '0900000005');

-- INSERT BẢNG Thanh_vien
INSERT INTO Thanh_vien (Ma_thanh_vien, Ma_khach_hang, Ma_hang_thanh_vien, Diem_tich_luy, Email, Trang_thai)
VALUES
(101, 1, 'HV001', 100, 'a@gmail.com', 1),
(102, 2, 'HV002', 550, 'b@gmail.com', 1),
(103, 3, 'HV002', 600, 'c@gmail.com', 1),
(104, 4, 'HV003', 2100, 'd@gmail.com', 1),
(105, 5, 'HV001', 50, 'e@gmail.com', 1);

-- INSERT BẢNG Nhan_vien
INSERT INTO Nhan_vien (Ma_nhan_vien, Ten_nhan_vien, So_dien_thoai, CCCD, Email, Mat_khau, Ma_chuc_vu, Ma_dia_chi)
VALUES
(201, 'Nguyễn Quang Anh', '0911111101', '0123456789', 'nv1@ushi.vn', '123456', 'CV001', 'DC001'),
(202, 'Lê Hồng Minh', '0911111102', '0123456790', 'nv2@ushi.vn', '123456', 'CV002', 'DC002'),
(203, 'Trần Văn Tuấn', '0911111103', '0123456791', 'nv3@ushi.vn', '123456', 'CV003', 'DC003'),
(204, 'Phạm Mỹ Diệu', '0911111104', '0123456792', 'nv4@ushi.vn', '123456', 'CV004', 'DC004'),
(205, 'Đỗ Thảo Ly', '0911111105', '0123456793', 'nv5@ushi.vn', '123456', 'CV005', 'DC005');

--INSERT BẢNG DANH MỤC MÓN ĂN
INSERT INTO Danh_muc_mon_an (Ma_danh_muc, Ten_danh_muc, Trang_thai)
VALUES
('DM001', 'Wagyu Beef', 1),
('DM002', 'Premium Aging Beef Steak', 1),
('DM003', 'Japanese Hamburger Steak', 1),
('DM004', 'Chicken & Seafood', 1),
('DM005', 'Doria & Pasta', 1),
('DM006', 'Others', 1),
('DM007', 'Buffet Tabehoudai', 1);

-- INSERT BẢNG Mon_an 
INSERT INTO Mon_an (Ma_mon_an, Ten_mon_an, Mo_ta, Don_gia, Hinh_anh, Kieu_mon, Ma_danh_muc)
VALUES
-- Món đơn
('MA001', 'Wagyu Steak A5', 'Thịt bò Wagyu A5 nhập khẩu, nướng vừa chín tới', 890000, 'wagyu_a5.jpg', 0, 'DM001'),
('MA002', 'Wagyu Sushi Set', 'Sushi bò Wagyu ủ tuổi, dùng kèm nước sốt đặc biệt', 350000, 'wagyu_sushi.jpg', 0, 'DM001'),
('MA005', 'Buffet Shin Tabehoudai', 'Buffet không giới hạn gồm bò Wagyu và lẩu Nhật', 799000, 'buffet_shin.jpg', 0, 'DM006'),
('MA006', 'Buffet AI Tabehoudai', 'Buffet cao cấp với bò Wagyu A5 và sushi thượng hạng', 1199000, 'buffet_ai.jpg', 0, 'DM007'),
('MA007', 'Japanese Hamburger Steak', 'Thịt bò xay Nhật Bản với sốt demi-glace', 290000, 'hamburger_steak.jpg', 0, 'DM004'),
('MA008', 'Cheese Doria', 'Cơm đút lò phô mai kiểu Nhật', 180000, 'cheese_doria.jpg', 0, 'DM005'),
('MA009', 'Seafood Pasta', 'Mì Ý hải sản sốt kem tươi', 220000, 'seafood_pasta.jpg', 0, 'DM005'),
('MA010', 'Grilled Chicken Teriyaki', 'Gà nướng sốt Teriyaki truyền thống', 200000, 'chicken_teriyaki.jpg', 0, 'DM004'),
('MA011', 'Wagyu Donburi', 'Cơm tô thịt bò Wagyu xào hành tây', 340000, 'wagyu_don.jpg', 0, 'DM001'),
('MA013', 'Wagyu Karubi', 'Ba chỉ bò Wagyu nướng BBQ', 470000, 'wagyu_karubi.jpg', 0, 'DM001'),
('MA014', 'Japanese Curry Rice', 'Cơm cà ri Nhật với thịt bò hầm', 210000, 'curry_rice.jpg', 0, 'DM004'),
('MA015', 'Spaghetti Bolognese', 'Mì Ý bò bằm sốt cà chua', 190000, 'spaghetti_bolognese.jpg', 0, 'DM005'),
('MA016', 'Shrimp Tempura', 'Tôm chiên giòn Tempura kiểu Nhật', 230000, 'shrimp_tempura.jpg', 0, 'DM006'),
('MA017', 'Wagyu Nigiri', 'Cơm cuộn bò Wagyu cháy cạnh', 330000, 'wagyu_nigiri.jpg', 0, 'DM001'),
('MA018', 'Teriyaki Pork Bowl', 'Cơm thịt heo sốt Teriyaki', 180000, 'pork_bowl.jpg', 0, 'DM004'),
('MA019', 'Green Salad', 'Salad rau tươi trộn giấm Nhật', 120000, 'green_salad.jpg', 0, 'DM006'),
('MA020', 'Matcha Ice Cream', 'Kem trà xanh Nhật Bản', 100000, 'matcha_icecream.jpg', 0, 'DM006'),

-- Combo
('CB001', 'Combo Couple', 'Set dành cho 2 người gồm bò Nhật, salad, súp miso', 980000, 'combo_couple.jpg', 1, 'DM003'),
('CB002', 'Combo Family 4 Pax', 'Set cho 4 người gồm thịt nướng Wagyu và lẩu', 1580000, 'combo_family.jpg', 1, 'DM002'),
('CB003', 'Irodori Combo', 'Combo bò & hải sản tươi sống, kèm Pepsi', 1150000, 'irodori_combo.jpg', 1, 'DM005'),
('CB004', 'Combo Ushi Premium', 'Combo cao cấp gồm bò Wagyu A5, sashimi, tempura', 1850000, 'combo_ushi.jpg', 1, 'DM002'),
('CB005', 'Combo Lunch Set', 'Combo bữa trưa tiết kiệm gồm cơm, salad, soup', 390000, 'combo_lunch.jpg', 1, 'DM003'),
('CB006', 'Combo Kids Meal', 'Set cho trẻ em gồm cơm trứng, gà chiên, nước trái cây', 250000, 'combo_kid.jpg', 1, 'DM003');

--INSERT BẢNG CHI TIẾT COMBO
INSERT INTO Combo_chi_tiet (Ma_combo, Ma_mon_don, So_luong)
VALUES
('CB001', 'MA001', 1), -- Wagyu Steak A5
('CB001', 'MA019', 2), -- Green Salad
('CB001', 'MA014', 2), -- Japanese Curry Rice
('CB002', 'MA001', 2),
('CB002', 'MA016', 2),
('CB002', 'MA009', 2),
('CB003', 'MA013', 1),
('CB003', 'MA016', 2),
('CB003', 'MA002', 2),
('CB004', 'MA001', 1),
('CB004', 'MA017', 2),
('CB004', 'MA016', 2),
('CB005', 'MA011', 1),
('CB005', 'MA019', 1),
('CB005', 'MA014', 1),
('CB006', 'MA020', 1),
('CB006', 'MA010', 1),
('CB006', 'MA014', 1);

-- INSERT BẢNG Phuong_thuc_thanh_toan
INSERT INTO Phuong_thuc_thanh_toan (Ma_phuong_thuc_thanh_toan, Ten_phuong_thuc_thanh_toan)
VALUES 
(1, 'Tiền mặt'),
(2, 'Thẻ ngân hàng'),
(3, 'Ví điện tử Momo'),
(4, 'ZaloPay'),
(5, 'Chuyển khoản');
SELECT*FROM Nhan_vien

-- INSERT BẢNG Hoa_don
INSERT INTO Hoa_don (Ma_hoa_don, Ma_khach_hang, Ma_nhan_vien, Ma_phuong_thuc_thanh_toan, Ma_ban, Ma_khuyen_mai, Tinh_trang, Tong_tien, VAT)
VALUES
('HD001', 1, 203, 1, 'B001', 'KM001', 1, 890000, 89000),
('HD002', 2, 203, 2, 'B002', 'KM002', 1, 1590000, 159000),
('HD003', 3, 203, 3, 'B003', 'KM003', 1, 490000, 49000),
('HD004', 4, 203, 4, 'B004', 'KM004', 1, 1250000, 125000),
('HD005', 5, 203, 5, 'B005', 'KM005', 0, 730000, 73000);

-- INSERT BẢNG Chi_tiet_hoa_don
INSERT INTO Chi_tiet_hoa_don (Ma_hoa_don, Ma_mon_an, So_luong, Trang_thai, Ghi_chu)
VALUES
('HD001', 'MA001', 2, 1, NULL),
('HD001', 'CB005', 1, 1, NULL),
('HD002', 'MA005', 3, 1, NULL),
('HD003', 'MA002', 1, 1, NULL),
('HD004', 'CB006', 2, 1, NULL);

