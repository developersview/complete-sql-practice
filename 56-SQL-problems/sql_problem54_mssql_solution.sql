/*
Meta (Hard Level)

The sales department has given you the sales figures for the first two months of 2023. 
You've been tasked with determining the percentage of weekly sales on the first and last day of every week. Consider Sunday as last day of week and Monday as first day of week.
In your output, include the week number, percentage sales for the first day of the week, and percentage sales for the last day of the week. Both proportions should be rounded to the nearest whole number.
*/
USE sqlpractice;

DROP TABLE IF EXISTS early_sales;
CREATE TABLE early_sales (
	invoicedate DATETIME, 
	invoiceno BIGINT, 
	quantity BIGINT, 
	stockcode NVARCHAR(50), 
	unitprice FLOAT
);

INSERT INTO early_sales (invoicedate, invoiceno, quantity, stockcode, unitprice) 
VALUES('2023-01-01 10:00:00', 1001, 5, 'A001', 20.0), ('2023-01-01 15:30:00', 1002, 3, 'A002', 30.0), ('2023-01-02 09:00:00', 1003, 10, 'A003', 15.0), ('2023-01-02 11:00:00', 1004, 2, 'A004', 50.0), 
('2023-01-08 10:30:00', 1005, 4, 'A005', 25.0), ('2023-01-08 14:45:00', 1006, 7, 'A006', 18.0), ('2023-01-15 08:00:00', 1007, 6, 'A007', 22.0), ('2023-01-15 16:00:00', 1008, 8, 'A008', 12.0), 
('2023-01-22 09:30:00', 1009, 3, 'A009', 40.0), ('2023-01-22 18:00:00', 1010, 5, 'A010', 35.0), ('2023-02-01 10:00:00', 1011, 9, 'A011', 20.0), ('2023-02-01 12:00:00', 1012, 2, 'A012', 60.0), 
('2023-02-05 09:30:00', 1013, 4, 'A013', 25.0), ('2023-02-05 13:00:00', 1014, 6, 'A014', 18.0), ('2023-02-12 10:00:00', 1015, 7, 'A015', 22.0), ('2023-02-12 14:00:00', 1016, 5, 'A016', 28.0);

SELECT * FROM early_sales;

-- solution
WITH WeeklySales AS (
    SELECT
        DATEPART(WEEK, invoicedate) AS week_number,
        SUM(quantity * unitprice) AS total_weekly_sales
    FROM early_sales
    WHERE invoicedate BETWEEN '2023-01-01' AND '2023-02-28'
    GROUP BY DATEPART(WEEK, invoicedate)
),
SalesByDay AS (
    SELECT
        DATEPART(WEEK, invoicedate) AS week_number,
        DATEPART(WEEKDAY, invoicedate) AS day_of_week,
        SUM(quantity * unitprice) AS daily_sales
    FROM early_sales
    WHERE invoicedate BETWEEN '2023-01-01' AND '2023-02-28'
    GROUP BY DATEPART(WEEK, invoicedate), DATEPART(WEEKDAY, invoicedate)
),
FirstAndLastDaySales AS (
    SELECT
        s.week_number,
        COALESCE(SUM(CASE WHEN s.day_of_week = 2 THEN s.daily_sales END), 0) AS monday_sales,
        COALESCE(SUM(CASE WHEN s.day_of_week = 7 THEN s.daily_sales END), 0) AS sunday_sales
    FROM SalesByDay s
    GROUP BY s.week_number
)
SELECT
    ws.week_number,
    ROUND(100.0 * fl.monday_sales / ws.total_weekly_sales, 0) AS monday_sales_percentage,
    ROUND(100.0 * fl.sunday_sales / ws.total_weekly_sales, 0) AS sunday_sales_percentage
FROM WeeklySales ws
JOIN FirstAndLastDaySales fl ON ws.week_number = fl.week_number
ORDER BY ws.week_number;