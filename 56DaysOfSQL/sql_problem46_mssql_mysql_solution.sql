/*
EY, TCS, Deloitte, (Medium Level)
In a marathon, gun time is counted from the moment of the formal start of the race while net time is counted from the moment a runner crosses a starting line.Both variables are in seconds.
You are asked to check if the interval between the two times is different for male and female runners. 
First, calculate the average absolute difference between the gun time and net time. Group the results by available genders (male and female). Output the absolute difference between those two values.
*/
USE sqlpractice;

DROP TABLE IF EXISTS marathon_male;
CREATE TABLE marathon_male (
	age BIGINT, 
	div_tot TEXT, 
	gun_time BIGINT, 
	hometown TEXT, 
	net_time BIGINT, 
	num BIGINT, 
	pace BIGINT, 
	person_name TEXT, 
	place BIGINT
);

INSERT INTO marathon_male (age, div_tot, gun_time, hometown, net_time, num, pace, person_name, place) 
VALUES (25, '1/100', 3600, 'New York', 3400, 101, 500, 'John Doe', 1), (30, '2/100', 4000, 'Boston', 3850, 102, 550, 'Michael Smith', 2), (22, '3/100', 4200, 'Chicago', 4150, 103, 600, 'David Johnson', 3);

DROP TABLE IF EXISTS marathon_female;
CREATE TABLE marathon_female (
	age BIGINT, 
	div_tot TEXT, 
	gun_time BIGINT, 
	hometown TEXT, 
	net_time BIGINT, 
	num BIGINT, 
	pace BIGINT, 
	person_name TEXT, 
	place BIGINT
);

INSERT INTO marathon_female (age, div_tot, gun_time, hometown, net_time, num, pace, person_name, place) 
VALUES (28, '1/100', 3650, 'San Francisco', 3600, 201, 510, 'Jane Doe', 1), (26, '2/100', 3900, 'Los Angeles', 3850, 202, 530, 'Emily Davis', 2), (24, '3/100', 4100, 'Seattle', 4050, 203, 590, 'Anna Brown', 3);

SELECT * FROM marathon_male;
SELECT * FROM marathon_female;

-- solution
WITH AvgTimeDiff AS (
	SELECT
		'Male' AS gender,
		AVG(ABS(gun_time - net_time)) AS avg_time_diff
	FROM
		marathon_male
	UNION ALL
	SELECT
		'Female' AS gender,
		AVG(ABS(gun_time - net_time)) AS avg_time_diff
	FROM
		marathon_female
)
SELECT
	ABS(
		MAX(CASE WHEN gender = 'Male' THEN avg_time_diff END) - 
		MAX(CASE WHEN gender = 'Female' THEN avg_time_diff END)
	) AS absolute_diff
FROM	
	AvgTimeDiff;

