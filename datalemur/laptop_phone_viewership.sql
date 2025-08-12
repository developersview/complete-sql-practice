SELECT
  SUM
    (
      CASE 
        WHEN device_type = 'laptop' THEN 1
        ELSE 0
      END
    ) AS laptop_reviews,
  SUM
    (
      CASE 
        WHEN device_type IN ('tablet', 'phone') THEN 1
        ELSE 0
      END
    ) AS mobile_reviews
    
FROM viewership;