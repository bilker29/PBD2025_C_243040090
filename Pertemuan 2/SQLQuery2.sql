--Hapus Database TokoRetailDB yang sudah ada
IF DB_ID('TokoRetailDB') IS NOT NULL
BEGIN
	USE master;
	DROP DATABASE TokoRetailDB;
END
GO

--Buat Database baru
CREATE DATABASE TokoRetailDB;
GO

USE TokoRetailDB;
GO

--Membuat Tabel Kategori
CREATE TABLE KategoriProduk(
	KategoriID INT IDENTITY(1,1) PRIMARY KEY,
	NamaKategori VARCHAR(100) NOT NULL UNIQUE
);
GO

--2. Membuat tabel Produk
CREATE TABLE Produk(
	ProdukID INT IDENTITY(1001,1) PRIMARY KEY,
	SKU VARCHAR(20) NOT NULL UNIQUE,
	NamaProduk VARCHAR(150) NOT NULL,
	Harga DECIMAL(10,2) NOT NULL,
	Stok INT NOT NULL,
	KategoriID INT NULL,
	
	CONSTRAINT CHK_HargaPositif CHECK (Harga >=0),
	CONSTRAINT CHK_StokPositif CHECK (Stok >= 0),
	CONSTRAINT FK_KategoriPositif
		FOREIGN KEY (KategoriID)
		REFERENCES KategoriProduk(KategoriID)

);
GO

/* 4. Buat tabel Pesanan Header */
CREATE TABLE PesananHeader (
PesananID INT IDENTITY(50001, 1) PRIMARY KEY,
PelangganID INT NOT NULL,
TanggalPesanan DATETIME2 DEFAULT GETDATE(),
StatusPesanan VARCHAR(20) NOT NULL,
CONSTRAINT CHK_StatusPesanan CHECK (StatusPesanan IN ('Baru', 'Proses',
'Selesai', 'Batal')),
CONSTRAINT FK_Pesanan_Pelanggan
FOREIGN KEY (PelangganID)
REFERENCES Pelanggan(PelangganID)
-- ON DELETE NO ACTION (Default)
);
GO



EXEC sp_help 'Produk';

-- 3. Membuat Tabel Pelanggan
CREATE TABLE Pelanggan (
	PelangganID INT IDENTITY(1,1) PRIMARY KEY,
	NamaDepan VARCHAR(50) NOT NULL,
	NamaBelakang VARCHAR(50) NOT NULL,
	Email VARCHAR(100) NOT NULL UNIQUE,
	NoTelepon VARCHAR(20) NULL,
	TanggalDaftar DATE DEFAULT GETDATE()
);
GO

EXEC sp_help 'Pelanggan';


/* 1. Memasukkan data Pelanggan */
-- Sintaks eksplisit (Best Practice)
INSERT INTO Pelanggan (NamaDepan, NamaBelakang, Email, NoTelepon)
VALUES
('Budi', 'Santoso', 'budi.santoso@email.com', '081234567890'),
('Fatur', 'Rahman', 'muhamad.fatur.rahaman@email.com', NULL); -- NoTelepon 

PRINT 'Data Pelanggan:';
SELECT *
FROM Pelanggan;

/* 2. Memasukkan data Kategori (Multi-row) */
INSERT INTO KategoriProduk (NamaKategori)
VALUES
('Elektronik'),
('Pakaian'),
('Buku');

PRINT 'Data Pelanggan:';
SELECT * FROM Pelanggan;
PRINT 'Data Kategori:';
SELECT * FROM KategoriProduk;

/* Masukkan data Produk yang merujuk ke KategoriID */
INSERT INTO Produk (SKU, NamaProduk, Harga, Stok, KategoriID)
VALUES
('ELEC-001', 'Laptop Pro 14 inch', 15000000.00, 50, 1), -- KategoriID 1 =
Elektronik
('PAK-001', 'Kaos Polos Putih', 75000.00, 200, 2), -- KategoriID 2 =
Pakaian
('BUK-001', 'Dasar-Dasar SQL', 120000.00, 100, 3); -- KategoriID 3 =
Buku