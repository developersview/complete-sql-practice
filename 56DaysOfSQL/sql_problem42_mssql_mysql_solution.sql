/*
Microsoft (Medium Level)
Write a query that returns the company (customer id column) with highest number of users that use desktop only.
*/
USE sqlpractice;

DROP TABLE IF EXISTS microsoft_fact_events;
CREATE TABLE microsoft_fact_events (
	id INT PRIMARY KEY, 
	time_id DATETIME, 
	user_id VARCHAR(50), 
	customer_id VARCHAR(50), 
	client_id VARCHAR(50), 
	event_type VARCHAR(50), 
	event_id INT
);

INSERT INTO microsoft_fact_events (id, time_id, user_id, customer_id, client_id, event_type, event_id) 
VALUES (1, '2024-12-01 10:00:00', 'U1', 'C1', 'desktop', 'click', 101), (2, '2024-12-01 11:00:00', 'U2', 'C1', 'mobile', 'view', 102), (3, '2024-12-01 12:00:00', 'U3', 'C2', 'desktop', 'click', 103), 
(4, '2024-12-01 13:00:00', 'U1', 'C1', 'desktop', 'click', 104), (5, '2024-12-01 14:00:00', 'U2', 'C1', 'tablet', 'view', 105), (6, '2024-12-01 15:00:00', 'U4', 'C3', 'desktop', 'click', 106), 
(7, '2024-12-01 16:00:00', 'U3', 'C2', 'desktop', 'click', 107), (8, '2024-12-01 17:00:00', 'U5', 'C4', 'desktop', 'click', 108), (9, '2024-12-01 18:00:00', 'U6', 'C4', 'mobile', 'view', 109), 
(10, '2024-12-01 19:00:00', 'U7', 'C5', 'desktop', 'click', 110);

SELECT * FROM microsoft_fact_events;

-- solution
WITH DesktopOnlyUser AS(
	SELECT
		customer_id,
		COUNT(CASE WHEN client_id = 'desktop' THEN user_id END) AS desktop_only_user_count,
		client_id,
		DENSE_RANK() OVER (ORDER BY COUNT(CASE WHEN client_id = 'desktop' THEN user_id END) DESC) AS rank
	FROM
		microsoft_fact_events
	GROUP BY customer_id, user_id, client_id
	)
SELECT
	customer_id,
	desktop_only_user_count
FROM
	DesktopOnlyUser
WHERE rank = 1;
