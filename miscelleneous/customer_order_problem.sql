-- Sample Data for customers and orders tables (PostgreSQL dialect)

-- Create customers table
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE
);

-- Insert sample data into customers table
INSERT INTO customers (customer_name, email) VALUES
('Alice Smith', 'alice.smith@example.com'),
('Bob Johnson', 'bob.j@example.com'),
('Charlie Brown', 'charlie.b@example.com'),
('Diana Prince', 'diana.p@example.com'),
('Eve Adams', 'eve.a@example.com'); -- Eve will have no orders to test non-conversion

-- Create orders table
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount NUMERIC(10, 2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Insert sample data into orders table
-- Using actual customer_ids from the customers table
INSERT INTO orders (customer_id, order_date, total_amount) VALUES
(1, '2023-01-15', 120.50), -- Alice
(1, '2023-02-20', 75.00),  -- Alice
(2, '2023-03-10', 200.00), -- Bob
(3, '2023-04-01', 50.25),  -- Charlie
(1, '2023-05-05', 30.00),  -- Alice
(2, '2023-06-12', 150.00); -- Bob

-- Note: Customer with customer_id 4 (Diana Prince) and 5 (Eve Adams) have no orders in this sample data.

SELECT * FROM customers;
SELECT * FROM orders;

-- customers who didnot make any transactions / orders
SELECT
	c.customer_id,
	c.customer_name,
	c.email
FROM
	customers c
		LEFT JOIN
	orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- Number of transactions per customer
SELECT
	c.customer_name,
	SUM(
		CASE
			WHEN o.order_id IS NOT NULL THEN 1
			ELSE 0
		END
	) AS number_of_orders
FROM
	customers c
		LEFT JOIN
	orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY number_of_orders DESC;

-- Number of transactions per customer (optimized way)
SELECT
	c.customer_name,
	COUNT(o.order_id) AS number_of_orders
FROM
	customers c
		LEFT JOIN
	orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY number_of_orders DESC;

-- Non-conversion percentage
WITH count_of_customers AS (
	SELECT 
		COUNT(DISTINCT c.customer_id) AS total_customer_count,
		SUM(
			CASE 
				WHEN o.order_id IS NULL THEN 1
				ELSE 0
			END			
		) AS total_customer_count_with_zero_orders
	FROM
		customers c
			LEFT JOIN
		orders o ON c.customer_id = o.customer_id
)
SELECT
	ROUND((total_customer_count_with_zero_orders::NUMERIC / total_customer_count) * 100, 2) AS non_conversion_percentage
FROM
	count_of_customers;	
