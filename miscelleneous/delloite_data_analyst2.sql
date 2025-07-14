DROP TABLE IF EXISTS payments;
CREATE TABLE payments (
 payment_id INT PRIMARY KEY,
 loan_id INT,
 payment_date DATE,
 amount_paid INT
);
INSERT INTO payments (payment_id, loan_id, payment_date, amount_paid) VALUES
(1, 1, '2023-01-10', 2000),
(2, 2, '2023-02-10', 1500),
(3, 2, '2023-02-20', 8000),
(4, 3, '2023-04-20', 5000),
(5, 4, '2023-03-15', 2000),
(6, 4, '2023-04-02', 4000),
(7, 5, '2023-04-02', 4000),
(8, 5, '2023-05-02', 3000);


DROP TABLE IF EXISTS loans;
CREATE TABLE loans (
 loan_id INT,
 customer_id INT,
 loan_amount INT,
 due_date DATE
);
INSERT INTO loans (loan_id, customer_id, loan_amount, due_date) VALUES
(1, 1, 5000, '2023-01-15'),
(2, 2, 8000, '2023-02-20'),
(3, 3, 10000, '2023-03-10'),
(4, 4, 6000, '2023-04-05'),
(5, 5, 7000, '2023-05-01');

SELECT * FROM payments;
SELECT * FROM loans;

-- solution
WITH payment_cte AS(
	SELECT
		loan_id,
		SUM(amount_paid) AS total_amount_paid,
		MAX(payment_date) AS last_payment_date
	FROM
		payments
	GROUP BY loan_id
)
SELECT
	l.loan_id,
	l.loan_amount,
	l.due_date,
	CASE
		WHEN l.loan_amount <= pc.total_amount_paid THEN 1
		ELSE 0
	END AS fully_paid_flag,
	CASE
		WHEN (l.loan_amount <= pc.total_amount_paid) AND (pc.last_payment_date <= l.due_date) THEN 1
		ELSE 0
	END AS on_time_flag
FROM
	loans l
		JOIN
	payment_cte pc ON l.loan_id = pc.loan_id;
