CREATE TABLE flights (
    cust_id INT,
    flight_id VARCHAR(255),
    origin VARCHAR(255),
    destination VARCHAR(255)
);

INSERT INTO flights (cust_id, flight_id, origin, destination) VALUES
(1, 'AI101', 'Chennai', 'Mumbai'),
(1, 'AI202', 'Nagpur', 'Jaipur'),
(1, 'AI303', 'Mumbai', 'Nagpur'),
(2, 'AI404', 'Bhopal', 'Indore'),
(2, 'AI505', 'Indore', 'Delhi');

SELECT * FROM flights

-- solution
WITH origin_details AS(
	SELECT
		cust_id,
		origin
	FROM
		flights
	WHERE origin NOT IN (
		SELECT f1.destination FROM flights f1 JOIN flights f2 ON f1.cust_id = f2.cust_id
	)
),
destination_details AS(
	SELECT
		cust_id,
		destination
	FROM
		flights
	WHERE destination NOT IN (
		SELECT f1.origin FROM flights f1 JOIN flights f2 ON f1.cust_id = f2.cust_id
	)
)
SELECT
	o.cust_id,
	o.origin AS origin_city,
	d.destination AS final_destination
FROM
	origin_details o
		JOIN
	destination_details d ON o.cust_id = d.cust_id;