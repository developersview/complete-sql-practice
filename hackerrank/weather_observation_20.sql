WITH cte AS (
    SELECT LAT_N, 
           ROW_NUMBER() OVER(ORDER BY LAT_N ASC) AS RN, 
           COUNT(*) OVER() AS Total_Rows 
    FROM STATION
)
SELECT 
    ROUND(LAT_N,4)
FROM 
    cte
WHERE RN = CEIL(Total_Rows/2) OR RN = FLOOR(Total_Rows/2)+1;