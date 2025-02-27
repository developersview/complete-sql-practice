/*
 Apple (Hard Level)
 Find the number of Apple product users and the number of total users with a device and group the counts by language. 
 Assume Apple products are only MacBook-Pro, iPhone 5s, and iPad-air. 
 Output the language along with the total number of Apple users and users with any device. 
 Order your results based on the number of total users in descending order.
*/
USE sqlpractice;

DROP TABLE IF EXISTS playbook_users;
CREATE TABLE playbook_users (
	user_id INT PRIMARY KEY,
	created_at DATETIME,
	company_id INT,
	language VARCHAR(50),
	activated_at DATETIME,
	state VARCHAR(50)
);

INSERT INTO playbook_users (user_id, created_at, company_id, language, activated_at, state) VALUES
(1, '2024-01-01 08:00:00', 101, 'English', '2024-01-05 10:00:00', 'Active'),
(2, '2024-01-02 09:00:00', 102, 'Spanish', '2024-01-06 11:00:00', 'Inactive'),
(3, '2024-01-03 10:00:00', 103, 'French', '2024-01-07 12:00:00', 'Active'),
(4, '2024-01-04 11:00:00', 104, 'English', '2024-01-08 13:00:00', 'Active'),
(5, '2024-01-05 12:00:00', 105, 'Spanish', '2024-01-09 14:00:00', 'Inactive');

DROP TABLE IF EXISTS playbook_events;
CREATE TABLE playbook_events ( 
	user_id INT, 
	occurred_at DATETIME, 
	event_type VARCHAR(50), 
	event_name VARCHAR(50), 
	location VARCHAR(100), 
	device VARCHAR(50)
);

INSERT INTO playbook_events (user_id, occurred_at, event_type, event_name, location, device) VALUES
(1, '2024-01-05 14:00:00', 'Click', 'Login', 'USA', 'MacBook-Pro'),
(2, '2024-01-06 15:00:00', 'View', 'Dashboard', 'Spain', 'iPhone 5s'),
(3, '2024-01-07 16:00:00', 'Click', 'Logout', 'France', 'iPad-air'),
(4, '2024-01-08 17:00:00', 'Purchase', 'Subscription', 'USA', 'Windows-Laptop'), (5, '2024-01-09 18:00:00', 'Click', 'Login', 'Spain', 'Android-Phone');

SELECT * FROM playbook_users;
SELECT * FROM playbook_events;

-- solution
WITH AppleUsers AS(
	SELECT
		pu.language,
		COUNT(DISTINCT pe.user_id) AS apple_user_count
	FROM
		playbook_users pu
			JOIN
		playbook_events pe ON pu.user_id = pe.user_id
	WHERE
		pe.device IN ('MacBook-Pro', 'iPhone 5s', 'iPad-air')
	GROUP BY pu.language
),
TotalUsers AS(
	SELECT
		pu.language,
		COUNT(DISTINCT pe.user_id) AS total_user_count
	FROM
		playbook_users pu
			JOIN
		playbook_events pe ON pu.user_id = pe.user_id
	WHERE
		pe.device IS NOT NULL
	GROUP BY pu.language
)
SELECT
	au.language,
	COALESCE(au.apple_user_count, 0) AS apple_user_count,
	tu.total_user_count
FROM
	AppleUsers au
		JOIN
	TotalUsers tu ON au.language = tu.language
ORDER BY total_user_count DESC;