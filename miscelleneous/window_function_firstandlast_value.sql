CREATE TABLE sales (
    region VARCHAR(50),
    sale_date DATE,
    revenue INT
);

INSERT INTO sales (region, sale_date, revenue) VALUES
('East', '2024-01-01', 100),
('East', '2024-02-01', 150),
('East', '2024-03-01', 200),
('West', '2024-01-01', 120),
('West', '2024-02-01', 130);

SELECT * FROM sales;

-- Wrong solution
SELECT DISTINCT
	region,
	FIRST_VALUE(revenue) OVER (PARTITION BY region ORDER BY sale_date) AS first_revenue,
	LAST_VALUE(revenue) OVER (PARTITION BY region ORDER BY sale_date) AS last_revenue
FROM sales
ORDER BY region;

-- solution 1
SELECT DISTINCT
	region,
	FIRST_VALUE(revenue) OVER (PARTITION BY region ORDER BY sale_date) AS first_revenue,
	LAST_VALUE(revenue) OVER (PARTITION BY region ORDER BY sale_date ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_revenue
FROM sales
ORDER BY region;

-- solution 2
SELECT DISTINCT
	region,
	FIRST_VALUE(revenue) OVER (PARTITION BY region ORDER BY sale_date ASC) AS first_revenue,
	FIRST_VALUE(revenue) OVER (PARTITION BY region ORDER BY sale_date DESC) AS last_revenue
FROM sales
ORDER BY region;