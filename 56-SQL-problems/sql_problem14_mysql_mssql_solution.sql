/*
What is the total sales revenue of Samantha and Lisa?
*/
USE sqlpractice;

DROP TABLE IF EXISTS sales_performance;
CREATE TABLE sales_performance (
	salesperson VARCHAR(50),
	widget_sales INT,
	sales_revenue INT,
	id INT PRIMARY KEY
);

INSERT INTO sales_performance (salesperson, widget_sales, sales_revenue, id) 
VALUES('Jim', 810, 40500, 1),('Bobby', 661, 33050, 2),('Samantha', 1006, 50300, 3),('Taylor', 984, 49200, 4),
('Tom', 403, 20150, 5),('Pat', 715, 35750, 6),('Lisa', 1247, 62350, 7);

SELECT * FROM sales_performance;

-- solution
SELECT 
	SUM(sales_revenue) AS total_sales_revenue
FROM 
	sales_performance
WHERE 
	salesperson IN ('Samantha', 'Lisa');