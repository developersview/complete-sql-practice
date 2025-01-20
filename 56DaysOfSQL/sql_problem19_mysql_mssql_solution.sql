/*
Walmart (Hard Level)
Identify users who started a session and placed an order on the same day.
For these users, calculate the total number of orders and the total order value for that day. 
Your output should include the user, the session date, the total number of orders, and the total order value for that day.
*/
USE sqlpractice;

DROP TABLE IF EXISTS sessions;
CREATE TABLE sessions(
	session_id INT PRIMARY KEY,
	user_id INT,
	session_date DATETIME
);

INSERT INTO sessions(session_id, user_id, session_date) VALUES (1, 1, '2024-01-01 00:00:00'),(2, 2, '2024-01-02 00:00:00'),
(3, 3, '2024-01-05 00:00:00'),(4, 3, '2024-01-05 00:00:00'),(5, 4, '2024-01-03 00:00:00'),(6, 4, '2024-01-03 00:00:00'),
(7, 5, '2024-01-04 00:00:00'),(8, 5, '2024-01-04 00:00:00'),(9, 3, '2024-01-05 00:00:00'),(10, 5, '2024-01-04 00:00:00');


DROP TABLE IF EXISTS order_summary;
CREATE TABLE order_summary (
	order_id INT PRIMARY KEY,
	user_id INT,
	order_value INT,
	order_date DATETIME
);

INSERT INTO order_summary (order_id, user_id, order_value, order_date) VALUES (1, 1, 152, '2024-01-01 00:00:00'),
(2, 2, 485, '2024-01-02 00:00:00'),(3, 3, 398, '2024-01-05 00:00:00'),(4, 3, 320, '2024-01-05 00:00:00'),
(5, 4, 156, '2024-01-03 00:00:00'),(6, 4, 121, '2024-01-03 00:00:00'),(7, 5, 238, '2024-01-04 00:00:00'),
(8, 5, 70, '2024-01-04 00:00:00'),(9, 3, 152, '2024-01-05 00:00:00'),(10, 5, 171, '2024-01-04 00:00:00');

SELECT * FROM sessions;
SELECT * FROM order_summary;

-- solution
SELECT 
    s.user_id,
    s.session_date,
    COUNT(os.order_id) AS total_orders,
    SUM(os.order_value) AS total_order_value
FROM
    sessions s
        JOIN
    order_summary os ON s.user_id = os.user_id
        AND CAST(s.session_date AS DATE) = CAST(os.order_date AS DATE)
GROUP BY s.user_id , s.session_date
HAVING COUNT(os.order_id) > 0;
