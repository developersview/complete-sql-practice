-- solution 1
SELECT card_name, issued_amount
FROM (
    SELECT 
        card_name,
        issued_amount,
        ROW_NUMBER() OVER (PARTITION BY card_name ORDER BY issue_year, issue_month) AS row_num
    FROM monthly_cards_issued
) AS ranked_cards
WHERE row_num = 1
ORDER BY issued_amount DESC;

-- solution 2
SELECT DISTINCT card_name, 
       FIRST_VALUE(issued_amount) OVER (PARTITION BY card_name ORDER BY issue_year, issue_month) AS issued_amount
FROM monthly_cards_issued
ORDER BY issued_amount DESC;

-- solution 3
WITH card_launch AS (
SELECT 
  card_name,
  issued_amount,
  MAKE_DATE(issue_year, issue_month, 1) AS issue_date,
  MIN(MAKE_DATE(issue_year, issue_month, 1)) OVER (PARTITION BY card_name) AS launch_DATE
FROM
  monthly_cards_issued
)
SELECT 
  card_name,
  issued_amount
FROM card_launch
WHERE issue_date = launch_date
ORDER BY issued_amount DESC;