---------------------------------------------------------------------------------
-- Tolong buatin rekap total pendapatan (sales) dari masing-masing kategori produk (category) dari tahun ke tahun dong.
SELECT 	
	CAST("year" AS VARCHAR) AS tahun,
	category,
	SUM(sales) AS Total_Pendapatan
FROM orders
GROUP BY "year", category 
ORDER BY "year" ASC;

-- Coba buktikan secara data, apakah semakin besar diskon yang dikasih ke suatu produk, profitnya malah makin hancur? Tolong cariin Rata-rata diskon (AVG(discount)) dan Total keuntungan (SUM(profit)) untuk setiap sub_category.
SELECT
	sub_category,
	AVG(discount) AS avg_disc,
	SUM(profit) AS total_profit
FROM orders
GROUP BY sub_category 
ORDER BY avg_disc ASC;

-- Tolong hitung dong total pendapatan (sales) berdasarkan wilayah (region) dan segmentasi pembelinya (segment). Bos pengen tau, di wilayah mana pelanggan 'Corporate' paling banyak ngeluarin duit.
SELECT 
	region,
	segment,
	SUM(sales) AS total_pendapatan
FROM orders
GROUP BY region, segment;
---------------------------------------------------------------------------------

-- Tolong dong cariin 5 sub_category produk yang ngasilin total profit paling besar, sekalian tampilin dari category apa.
SELECT 
	sub_category,
	SUM(profit) AS total_profit,
	category
FROM orders
GROUP BY sub_category 
ORDER BY total_profit  DESC 
LIMIT 5;

-- Siapa nama manajer (Person) yang berhasil mencetak total sales paling tinggi, dan dia pegang region apa?
SELECT 
	p.person,
	o.region,
	SUM(o.sales) AS jumlah
FROM people p 
JOIN orders o ON p.Region = o.region
GROUP BY p.person, o.region
ORDER BY jumlah DESC
LIMIT 1;

-- Tolong cariin 10 nama produk (product_name) yang transaksinya paling sering diretur (dikembalikan)!
SELECT 
	o.product_name,
	COUNT(o.product_name) AS total_returned
FROM orders o 
JOIN "returns" r ON o.order_id = r."Order ID" 
GROUP BY o.product_name 
ORDER BY COUNT(o.product_name) DESC
LIMIT 10;

-- Cariin dong 10 nama pelanggan (customer_name) yang total belanjanya (sales) paling gede, tapi syaratnya mereka nggak pernah minta diskon (total discount = 0) di semua transaksinya.
SELECT 
	customer_name,
	SUM(sales) AS total_sales
FROM orders
GROUP BY customer_name
HAVING SUM(discount) = 0
ORDER BY total_sales DESC
LIMIT 10;

-- Tolong dong keluarin daftar state (negara bagian) yang ngasih total kerugian (artinya total profit-nya di bawah nol / minus).
SELECT 
	state,
	SUM(profit) AS total_profit
FROM orders
GROUP BY state 
HAVING SUM(profit) < 0
ORDER BY total_profit ASC;

-- Dari 5 Negara Bagian (state) yang total penjualannya paling tinggi, tolong cekin dong berapa kali masing-masing dari mereka ngeretur barang?
WITH TopStates AS(
	SELECT
		state
	FROM orders
	GROUP BY state 
	ORDER BY SUM(sales) DESC 
	LIMIT 5
)
SELECT 
	t.state,
	COUNT(r."Order ID" ) AS Total_Returned
FROM TopStates t
JOIN orders	o ON t.state = o.state 
JOIN "returns" r ON o.order_id = r."Order ID"
GROUP BY t.state 
ORDER BY Total_Returned DESC;
	
