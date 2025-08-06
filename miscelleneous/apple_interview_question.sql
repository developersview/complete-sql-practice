CREATE TABLE user_events (
    id INT PRIMARY KEY,
    time_id DATE,
    user_id VARCHAR(255),
    customer_id VARCHAR(255),
    client_id VARCHAR(255),
    event_type VARCHAR(255),
    event_id INT
);

INSERT INTO user_events (id, time_id, user_id, customer_id, client_id, event_type, event_id) VALUES
(1, '2020-02-28', '3668-QPYBK', 'Sendit', 'desktop', 'message sent', 3),
(2, '2020-02-28', '7892-POOKP', 'Connectix', 'mobile', 'file received', 2),
(3, '2020-04-03', '9763-GRSKD', 'Zoomit', 'desktop', 'video call received', 7),
(4, '2020-04-02', '9763-GRSKD', 'Connectix', 'desktop', 'video call received', 7);

SELECT * FROM user_events;


-- solution
WITH user_event_stat AS (
	SELECT
		client_id,
		COUNT(*) AS total_events,
		SUM(
			CASE
				WHEN event_type IN ('video call received', 'video call sent', 'voice call received', 'voice call sent') THEN 1
				ELSE 0
			END
		) AS filtered_events
	FROM
		user_events
	GROUP BY client_id		
)
SELECT
	client_id
FROM
	user_event_stat
WHERE filtered_events * 1.0 / total_events >= 0.5;