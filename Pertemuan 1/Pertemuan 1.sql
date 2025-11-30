Create DATABASE TokoRetailDB;

USE TokoRetailDB;

--table

CREATE TABLE Produk (
	ProdukID INT,
	SKU VARCHAR(15),
	NamaProduk VARCHAR (100),
	Harga DECIMAL(10,2),
	Stok INT
);

EXEC sp_help 'Produk'; 

CREATE TABLE Pelanggan (
-- IDENTITY(1,1) adalah sintaks SQL Server untuk auto-increment
-- Dimulai dari 1, bertambah 1 setiap ada data baru.
PelangganID INT IDENTITY(1,1) PRIMARY KEY,
NamaDepan VARCHAR(50) NOT NULL,
NamaBelakang VARCHAR(50) NULL,
Email VARCHAR(100) NOT NULL UNIQUE,
TanggalDaftar DATE DEFAULT GETDATE()
);

-- Cek struktur dan constraint
EXEC sp_help 'Pelanggan';

CREATE TABLE PesananHeader (
PesananID INT IDENTITY(1,1) PRIMARY KEY,
TanggalPesanan DATETIME2 NOT NULL,
-- Ini adalah kolom Foreign Key
PelangganID INT NOT NULL,
StatusPesanan VARCHAR(10) NOT NULL,
-- Mendefinisikan constraint FOREIGN KEY (out-of-line)
CONSTRAINT FK_Pesanan_Pelanggan
FOREIGN KEY (PelangganID)
REFERENCES Pelanggan(PelangganID),
-- Mendefinisikan constraint CHECK
CONSTRAINT CHK_StatusPesanan
CHECK (StatusPesanan IN ('Baru', 'Proses', 'Selesai'))
);

-- Cek relasi
EXEC sp_help 'PesananHeader';

-- 1. Menambahkan Primary Key ke tabel Produk
-- (Kita asumsikan ProdukID sudah diisi data unik dan NOT NULL,
-- tapi karena tabel kita masih kosong, kita tambahkan NOT NULL dulu)
ALTER TABLE Produk
ALTER COLUMN ProdukID INT NOT NULL;
GO
ALTER TABLE Produk
ADD CONSTRAINT PK_Produk PRIMARY KEY (ProdukID);
GO
-- 2. Menambahkan kolom NoTelepon ke tabel Pelanggan
ALTER TABLE Pelanggan
ADD NoTelepon VARCHAR(20) NULL;
GO
-- 3. Mengubah kolom Harga di Produk agar wajib diisi
ALTER TABLE Produk
ALTER COLUMN Harga DECIMAL(10, 2) NOT NULL;

EXEC sp_help 'Produk';