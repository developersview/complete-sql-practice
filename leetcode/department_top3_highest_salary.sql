# Write your MySQL query statement below
WITH salary_details AS (
    SELECT
        d.name AS Department,
        e.name AS Employee,
        e.salary AS Salary,
        DENSE_RANK() OVER (PARTITION BY d.name ORDER BY e.salary DESC) AS rnk
    FROM
        employee e
            JOIN
        department d ON e.departmentId = d.id
)
SELECT
    Department,
    Employee,
    Salary
FROM
    salary_details
WHERE rnk <=3;