WITH supercloud_customer AS (
  SELECT
    c.customer_id,
    COUNT(DISTINCT p.product_category) AS product_count
    
  FROM
    customer_contracts c
      JOIN
    products p ON c.product_id = p.product_id
  GROUP BY c.customer_id
)
SELECT
  customer_id
FROM
  supercloud_customer
WHERE product_count = (
  SELECT
    COUNT(DISTINCT product_category) AS distinct_product_count
  FROM
    products
);