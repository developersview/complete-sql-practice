WITH cte AS (
  SELECT
    city,
    COUNT(*) AS total_orders
  FROM
    trades t
      JOIN
    users u ON t.user_id = u.user_id
  WHERE t.status = 'Completed'
  GROUP BY u.city
),
final_cte AS (
  SELECT
    city,
    total_orders,
    ROW_NUMBER() OVER (ORDER BY total_orders DESC) AS rnk
  FROM
    cte
)
SELECT
  city,
  total_orders
FROM
  final_cte
WHERE rnk <= 3;