/*
Calculate the cumulative sales for each store, but only 
include dates where the daily sales exceeded the store's average daily sales.
*/
DROP TABLE IF EXISTS Sales_Data;
CREATE TABLE Sales_Data (
 Store_ID INT,
 Sale_Date DATE,
 Daily_Sales INT
);

INSERT INTO Sales_Data (Store_ID, Sale_Date, Daily_Sales) VALUES
(1, '2024-06-01', 1000),(1, '2024-06-02', 1200),(1, '2024-06-03', 800),
(1, '2024-06-04', 1500),(2, '2024-06-01', 500),
(2, '2024-06-02', 700),(2, '2024-06-03', 900),
(2, '2024-06-04', 400);

SELECT * FROM Sales_Data;

-- solution
WITH avg_sales_data AS (
	SELECT 
		store_id, 
		AVG(Daily_Sales) AS avg_sale
	FROM Sales_Data
	GROUP BY store_id
)
SELECT
	sd.store_id,
	sd.sale_date,
	sd.daily_sales,
	SUM(sd.daily_sales) OVER (PARTITION BY sd.store_id ORDER BY sd.sale_date) AS cummulative_sale
FROM
	Sales_Data sd
		JOIN
	avg_sales_data asd ON sd.store_id = asd.store_id
WHERE sd.daily_sales > asd.avg_sale;