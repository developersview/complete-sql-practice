DROP TABLE IF EXISTS product_spend;

CREATE TABLE product_spend (
    category VARCHAR(50),
    product VARCHAR(100),
    user_id INT,
    spend DECIMAL(10, 2), -- DECIMAL is good for currency to avoid floating-point inaccuracies
    transaction_date TIMESTAMP -- Use DATETIME for SQL Server/MySQL, TIMESTAMP for PostgreSQL
);

INSERT INTO product_spend (category, product, user_id, spend, transaction_date) VALUES
('appliance', 'refrigerator', 165, 246.00, '2021-12-26 12:00:00'),
('appliance', 'refrigerator', 123, 299.99, '2022-03-02 12:00:00'),
('appliance', 'washing machine', 123, 219.80, '2022-03-02 12:00:00'),
('electronics', 'vacuum', 178, 152.00, '2022-04-05 12:00:00'),
('electronics', 'wireless headset', 156, 249.90, '2022-07-08 12:00:00'),
('electronics', 'vacuum', 145, 189.00, '2022-07-15 12:00:00');

SELECT * FROM product_spend;

WITH product_spend_rank AS (
	SELECT
		category,
		product,
		SUM(spend) as total_spend,
		DENSE_RANK() OVER(PARTITION BY category ORDER BY SUM(spend) DESC) as rnk
	FROM
		product_spend
	WHERE EXTRACT(YEAR FROM transaction_date) = 2022
	GROUP BY category, product
)
SELECT
	category, product, total_spend
FROM
	product_spend_rank
WHERE rnk <= 2;



















