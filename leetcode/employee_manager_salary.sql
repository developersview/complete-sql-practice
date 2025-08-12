# Write your MySQL query statement below
SELECT
    e.name AS Employee
FROM
    Employee e
        JOIN
    Employee m ON m.id = e.managerId
WHERE e.salary > m.salary;