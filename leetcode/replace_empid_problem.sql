SELECT 
    eu.unique_id, em.name
FROM
    employees em
        LEFT JOIN
    employeeuni eu ON em.id = eu.id;