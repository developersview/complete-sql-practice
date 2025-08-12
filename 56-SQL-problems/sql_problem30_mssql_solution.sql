/*
Amazon (Hard Level)
Given the users' sessions logs on a particular day, 
calculate how many hours each user was active that day. Note: The session starts when state=1 and ends when state=0.
*/
USE sqlpractice;

DROP TABLE IF EXISTS customer_state_log;
CREATE TABLE customer_state_log (
	cust_id VARCHAR(10),
	state INT,
	timestamp TIME
);

INSERT INTO customer_state_log (cust_id, state, timestamp) 
VALUES('c001', 1, '07:00:00'),('c001', 0, '09:30:00'),('c001', 1, '12:00:00'),('c001', 0, '14:30:00'),('c002', 1, '08:00:00'),
('c002', 0, '09:30:00'),('c002', 1, '11:00:00'),('c002', 0, '12:30:00'),('c002', 1, '15:00:00'),('c002', 0, '16:30:00'),
('c003', 1, '09:00:00'),('c003', 0, '10:30:00'),('c004', 1, '10:00:00'),('c004', 0, '10:30:00'),('c004', 1, '14:00:00'),
('c004', 0, '15:30:00'),('c005', 1, '10:00:00'),('c005', 0, '14:30:00'),('c005', 1, '15:30:00'),('c005', 0, '18:30:00');

SELECT * FROM customer_state_log;

-- solution
WITH SessionDuration AS(
	SELECT
		cust_id,
		CAST(LAG(timestamp) OVER (PARTITION BY cust_id ORDER BY timestamp) AS TIME) AS session_start,
		CAST(timestamp AS TIME) AS session_end
	FROM
		customer_state_log
	WHERE state = 0
),
ActiveHours AS(
	SELECT
		cust_id,
		DATEDIFF(HOUR, session_start, session_end) AS active_hours
	FROM
		SessionDuration
	WHERE session_start IS NOT NULL
)
SELECT
	cust_id,
	SUM(active_hours) AS total_active_hours
FROM
	ActiveHours
GROUP BY cust_id;