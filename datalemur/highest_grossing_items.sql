WITH product_spend_cte AS (
  SELECT
    category,
    product,
    SUM(spend) AS total_spend,
    DENSE_RANK() OVER(PARTITION BY category ORDER BY SUM(spend) DESC) AS rnk
  FROM 
    product_spend
  WHERE EXTRACT(YEAR FROM transaction_date) = 2022
  GROUP BY product, category
)
SELECT
  category,
  product,
  total_spend
FROM
  product_spend_cte
WHERE rnk <= 2;