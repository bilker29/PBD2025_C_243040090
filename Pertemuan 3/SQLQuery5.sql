--Gunakan tabel Sales.SalesOrderDetail (Tabel detail transaksi).
--1. Tampilkan ProductID dan total uang yang didapat (LineTotal) dari produk
--tersebut.
--2. Hanya hitung transaksi yang OrderQty (jumlah beli) >= 2.
--3. Kelompokkan berdasarkan ProductID.
--4. Filter agar hanya menampilkan produk yang total uangnya (SUM(LineTotal))di atas $50,000.
--5. Urutkan dari pendapatan tertinggi.
--6. Ambil 10 produk teratas saja.

SELECT TOP 10 ProductID,SUM(LineTotal) AS LineTotal
FROM Sales.SalesOrderDetail
WHERE OrderQty >= 2
GROUP BY ProductID
HAVING SUM(LineTotal) > 50000
ORDER BY LineTotal DESC;