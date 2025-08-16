WITH salary_cte AS (
  SELECT
    d.department_name,
    e.name,
    e.salary,
    DENSE_RANK() OVER(PARTITION BY d.department_id ORDER BY e.salary DESC) AS rnk
  FROM 
    employee e
      JOIN
    department d ON e.department_id = d.department_id
)
SELECT
  department_name,
  name,
  salary
FROM
  salary_cte
WHERE rnk <= 3
ORDER BY department_name ASC, salary DESC, name ASC;