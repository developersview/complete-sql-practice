-- Solution without Join
SELECT 
    v.customer_id AS customer_id,
    COUNT(v.visit_id) AS count_no_trans
FROM
    visits v
WHERE
    v.visit_id NOT IN (SELECT 
            t.visit_id
        FROM
            transactions t)
GROUP BY v.customer_id;


-- Solution using Join
SELECT 
    v.customer_id AS customer_id,
    COUNT(v.visit_id) AS count_no_trans
FROM
    visits v
        LEFT JOIN
    transactions t ON v.visit_id = t.visit_id
WHERE
    t.transaction_id IS NULL
GROUP BY v.customer_id;