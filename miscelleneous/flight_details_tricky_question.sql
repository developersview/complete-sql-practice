DROP TABLE IF EXISTS flight_details;
CREATE TABLE flight_details (
    cust_id INT,
    flight_id VARCHAR(255),
    origin VARCHAR(255),
    destination VARCHAR(255)
);

INSERT INTO flight_details (cust_id, flight_id, origin, destination) VALUES
-- Itinerary for cust_id 1
(1, 'SG1234', 'Delhi', 'Hyderabad'),
(1, '69876', 'Hyderabad', 'Kochi'),
(1, 'SG3476', 'Kochi', 'Mangalore'),

-- Itinerary for cust_id 2
(2, '68749', 'Mumbai', 'Varanasi'),
(2, 'SG5723', 'Varanasi', 'Delhi'),

-- Itinerary for cust_id 3
(3, 'AB101', 'Bangalore', 'Chennai'),
(3, 'CD202', 'Chennai', 'Pune'),

-- Itinerary for cust_id 4
(4, 'EF303', 'Pune', 'Goa'),
(4, 'GH404', 'Goa', 'Mumbai'),

-- Itinerary for cust_id 5
(5, 'IJ505', 'Kolkata', 'Patna'),
(5, 'KL606', 'Patna', 'Lucknow');

SELECT * FROM flight_details;


-- solution
WITH origin_details AS(
	SELECT
		f1.cust_id,
		f1.origin,
		f2.destination
	FROM
		flight_details f1
			LEFT JOIN
		flight_details f2 ON f1.cust_id = f2.cust_id AND f1.origin = f2.destination
	WHERE f2.destination IS NULL
),
destination_details AS(
	SELECT
		f1.cust_id,
		f1.destination,
		f2.origin
	FROM
		flight_details f1
			LEFT JOIN
		flight_details f2 ON f1.cust_id = f2.cust_id AND f1.destination = f2.origin
	WHERE f2.origin IS NULL
)
SELECT
	o.cust_id,
	o.origin AS origin_city,
	d.destination AS final_destination
FROM
	origin_details o
		JOIN
	destination_details d ON o.cust_id = d.cust_id;


-- solution 2
WITH passenger_details AS (
SELECT
	cust_id,
	ROW_NUMBER() OVER(PARTITION BY cust_id ORDER BY cust_id) AS rnk,
	FIRST_VALUE(origin) OVER(PARTITION BY cust_id) AS origin_city,
	LAST_VALUE(destination) OVER(PARTITION BY cust_id) AS final_destination
FROM flight_details
)
SELECT
	cust_id,
	origin_city,
	final_destination
FROM
	passenger_details
WHERE rnk = 1
ORDER BY cust_id;