WITH job_count_cte AS (
  SELECT
    company_id,
    title,
    description,
    COUNT(*) AS job_count
  FROM
    job_listings
  GROUP BY company_id, title, description
  HAVING COUNT(*) > 1
)
SELECT
  COUNT(*) AS duplicate_companies
FROM
  job_count_cte;