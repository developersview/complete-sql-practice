/*
Tesla (Hard Level)

The company you are working for wants to anticipate their staffing needs by identifying their top two busiest times of the week. 
To find this, each day should be segmented into differents parts using following criteria:

Morning: Before 12 p.m. (not inclusive)
Early afternoon: 12 -15 p.m.
Late afternoon: after 15 p.m. (not inclusive)

Your output should include the day and time of day combination for the two busiest times, i.e. the combinations with the most orders, 
along with the number of orders (e.g. top two results could be Friday Late afternoon with 12 orders and Sunday Morning with 10 orders). 
The company has also requested that the day be displayed in text format (i.e. Monday).
*/
USE sqlpractice;

DROP TABLE IF EXISTS sales_log;
CREATE TABLE sales_log (
	order_id BIGINT PRIMARY KEY,
	product_id BIGINT,
	timestamp DATETIME
);

INSERT INTO sales_log (order_id, product_id, timestamp) VALUES(1, 101, '2024-12-15 09:30:00'), (2, 102, '2024-12-15 11:45:00'), (3, 103, '2024-12-15 12:10:00'), (4, 104, '2024-12-15 13:15:00'), (5, 105, '2024-12-15 14:20:00'), (6, 106, '2024-12-15 15:30:00'), (7, 107, '2024-12-15 16:40:00'), (8, 108, '2024-12-16 09:50:00'), (9, 109, '2024-12-16 10:30:00'), (10, 110, '2024-12-16 12:05:00'), (11, 111, '2024-12-16 13:50:00'), (12, 112, '2024-12-16 14:15:00'), (13, 113, '2024-12-16 15:30:00'), (14, 114, '2024-12-17 09:45:00'), (15, 115, '2024-12-17 11:20:00'), (16, 116, '2024-12-17 12:25:00'), (17, 117, '2024-12-17 13:30:00'), (18, 118, '2024-12-17 14:55:00'), (19, 119, '2024-12-17 15:10:00'), (20, 120, '2024-12-18 10:40:00');

SELECT * FROM sales_log;

--solution
WITH TimePeriodOrders AS (
    SELECT
        DATENAME(WEEKDAY, timestamp) AS day_of_week,  -- Get the day name (e.g., Monday, Tuesday)
        CASE
            WHEN DATEPART(HOUR, timestamp) < 12 THEN 'Morning'
            WHEN DATEPART(HOUR, timestamp) >= 12 AND DATEPART(HOUR, timestamp) < 15 THEN 'Early afternoon'
            ELSE 'Late afternoon'
        END AS time_of_day,
        COUNT(order_id) AS order_count
    FROM sales_log
    GROUP BY DATENAME(WEEKDAY, timestamp),
        CASE
            WHEN DATEPART(HOUR, timestamp) < 12 THEN 'Morning'
            WHEN DATEPART(HOUR, timestamp) >= 12 AND DATEPART(HOUR, timestamp) < 15 THEN 'Early afternoon'
            ELSE 'Late afternoon'
        END
),
RankedOrders AS (
    SELECT
        day_of_week,
        time_of_day,
        order_count,
        RANK() OVER (ORDER BY order_count DESC) AS rank
    FROM TimePeriodOrders
)
SELECT
    day_of_week,
    time_of_day,
    order_count
FROM RankedOrders
WHERE rank <= 2
ORDER BY rank, order_count DESC;
