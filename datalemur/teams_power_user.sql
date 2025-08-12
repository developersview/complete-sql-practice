-- solution 1
SELECT 
    sender_id, 
    COUNT(message_id) AS messgae_count
FROM
    messages
WHERE
    sent_date BETWEEN '08/01/2022' AND '08/30/2022'
GROUP BY sender_id
ORDER BY messgae_count DESC
LIMIT 2;

-- solution 2
WITH cte AS (
  SELECT
    sender_id,
    COUNT(*) AS message_count
  FROM
    messages
  WHERE EXTRACT(YEAR FROM sent_date) = 2022 AND EXTRACT(MONTH FROM sent_date) = 8
  GROUP BY sender_id
),
final_cte AS (
  SELECT
    sender_id,
    message_count,
    ROW_NUMBER() OVER (ORDER BY message_count DESC) AS rnk
  FROM
    cte
)
SELECT
  sender_id, message_count
FROM
  final_cte
WHERE rnk <= 2;

-- solution 3
WITH cte AS (
  SELECT
    sender_id,
    COUNT(*) AS message_count,
    ROW_NUMBER() OVER (ORDER BY COUNT(*) DESC) AS rnk
  FROM
    messages
  WHERE EXTRACT(YEAR FROM sent_date) = 2022 AND EXTRACT(MONTH FROM sent_date) = 8
  GROUP BY sender_id
)
SELECT
  sender_id, message_count
FROM
  cte
WHERE rnk <= 2;