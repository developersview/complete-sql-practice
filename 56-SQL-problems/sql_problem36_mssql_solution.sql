/*
Uber (Hard Level)
Find the most profitable location. 
Write a query that calculates the average signup duration and average transaction amount for each location, 
and then compare these two measures together by taking the ratio of the average transaction amount and average duration for each location.
*/
USE sqlpractice;

DROP TABLE IF EXISTS signups;
CREATE TABLE signups (
	signup_id INT PRIMARY KEY, 
	signup_start_date DATETIME, 
	signup_stop_date DATETIME, 
	plan_id INT, location VARCHAR(100)
);

INSERT INTO signups (signup_id, signup_start_date, signup_stop_date, plan_id, location) 
VALUES (1, '2020-01-01 10:00:00', '2020-01-01 12:00:00', 101, 'New York'), (2, '2020-01-02 11:00:00', '2020-01-02 13:00:00', 102, 'Los Angeles'), 
(3, '2020-01-03 10:00:00', '2020-01-03 14:00:00', 103, 'Chicago'), (4, '2020-01-04 09:00:00', '2020-01-04 10:30:00', 101, 'San Francisco'), 
(5, '2020-01-05 08:00:00', '2020-01-05 11:00:00', 102, 'New York');

DROP TABLE IF EXISTS transactions;
CREATE TABLE transactions (
	transaction_id INT PRIMARY KEY,
	signup_id INT,
	transaction_start_date DATETIME,
	amt FLOAT,
	FOREIGN KEY (signup_id) REFERENCES signups(signup_id)
);

INSERT INTO transactions (transaction_id, signup_id, transaction_start_date, amt) 
VALUES (1, 1, '2020-01-01 10:30:00', 50.00), (2, 1, '2020-01-01 11:00:00', 30.00), (3, 2, '2020-01-02 11:30:00', 100.00), 
(4, 2, '2020-01-02 12:00:00', 75.00), (5, 3, '2020-01-03 10:30:00', 120.00), (6, 4, '2020-01-04 09:15:00', 80.00), (7, 5, '2020-01-05 08:30:00', 90.00);

SELECT * FROM signups;
SELECT * FROM transactions;

-- solution
WITH SignupDuration AS (
	SELECT
		signup_id,
		location,
		DATEDIFF(MINUTE, signup_start_date, signup_stop_date) AS signup_duration_minute
	FROM
		signups
),
TransactionAmount AS(
	SELECT
		signup_id, 
		AVG(amt) AS avg_transaction_amt
	FROM
		transactions
	GROUP BY signup_id
)
SELECT
	s.location,
	AVG(s.signup_duration_minute) AS avg_signup_duration,
	AVG(t.avg_transaction_amt) AS avg_transaction_amount,
	CASE
		WHEN AVG(s.signup_duration_minute) = 0 THEN 0
		ELSE AVG(t.avg_transaction_amt) / AVG(s.signup_duration_minute)
	END AS ratio
FROM
	SignupDuration s
		JOIN
	TransactionAmount t ON s.signup_id = t.signup_id
GROUP BY s.location
ORDER BY ratio DESC;