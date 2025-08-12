SELECT 
    w1.id
FROM
    weather w1
        JOIN
    weather w2 ON DATEDIFF(w1.recorddate, w2.recorddate) = 1
WHERE
    w1.temperature > w2.temperature;