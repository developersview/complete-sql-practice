/*
Microsoft (Hard Level)
Find the total number of downloads for paying and non-paying users by date. 
Include only records where non-paying customers have more downloads than paying customers. 
The output should be sorted by earliest date first and contain 3 columns date, non-paying downloads, paying downloads. 
*/
USE sqlpractice;

DROP TABLE IF EXISTS ms_user_dimension;
CREATE TABLE ms_user_dimension (
	user_id INT PRIMARY KEY,
	acc_id INT
);
INSERT INTO ms_user_dimension (user_id, acc_id) VALUES (1, 101),(2, 102),(3, 103),(4, 104),(5, 105);

DROP TABLE IF EXISTS ms_acc_dimension;
CREATE TABLE ms_acc_dimension (
	acc_id INT PRIMARY KEY,
	paying_customer VARCHAR(10)
);
INSERT INTO ms_acc_dimension (acc_id, paying_customer) VALUES (101, 'Yes'),(102, 'No'),(103, 'Yes'),(104, 'No'),(105, 'No');

DROP TABLE IF EXISTS ms_download_facts;
CREATE TABLE ms_download_facts (
	date DATETIME,
	user_id INT,
	downloads INT
);
INSERT INTO ms_download_facts (date, user_id, downloads) VALUES ('2024-10-01', 1, 10),('2024-10-01', 2, 15),
('2024-10-02', 1, 8),('2024-10-02', 3, 12),('2024-10-02', 4, 20),('2024-10-03', 2, 25),('2024-10-03', 5, 18);

SELECT * FROM ms_user_dimension;
SELECT * FROM ms_acc_dimension;
SELECT * FROM ms_download_facts;

-- solution
SELECT 
    DATE(d.date) AS date,
    SUM(CASE
        WHEN a.paying_customer = 'NO' THEN d.downloads
        ELSE 0
    END) AS non_paying_downloads,
    SUM(CASE
        WHEN a.paying_customer = 'YES' THEN d.downloads
        ELSE 0
    END) AS paying_downloads
FROM
    ms_user_dimension u
        JOIN
    ms_acc_dimension a ON u.acc_id = a.acc_id
        JOIN
    ms_download_facts d ON u.user_id = d.user_id
GROUP BY date
HAVING non_paying_downloads > paying_downloads
ORDER BY date;
