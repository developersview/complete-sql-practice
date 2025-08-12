SELECT 
    e.name
FROM
    employee e
        INNER JOIN
    employee m ON e.id = m.managerId
GROUP BY m.managerId
HAVING COUNT(m.managerId) >= 5;