WITH max_salary AS(
    SELECT 
        d.name AS Department,
        e.name AS Employee,
        e.salary AS Salary,
        DENSE_RANK() OVER(PARTITION BY d.name ORDER BY e.salary DESC) AS rank
    FROM
        Employee e
    JOIN
        Department d ON d.id = e.departmentId
)
SELECT Department, Employee, Salary
FROM max_salary
WHERE rank = 1; 