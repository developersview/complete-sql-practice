drop table if exists loan_tbl;

create table loan_tbl (
	loan_id INT,
	customer_id INT,
	loan_amount INT,
	due_date DATE
);

insert into loan_tbl (loan_id, customer_id, loan_amount, due_date) values
(1, 1, 5000, '2023-01-15'),
(2, 2, 8000, '2023-02-20'),
(3, 3, 10000, '2023-03-10'),
(4, 4, 6000, '2023-04-05'),
(5, 5, 7000, '2023-05-01');


drop table if exists payment_tbl;

create table payment_tbl (
	payment_id INT,
	loan_id INT,
	payment_date DATE,
	amount_paid INT
);

insert into payment_tbl (payment_id, loan_id, payment_date, amount_paid) values
(1, 1, '2023-01-10', 2000),
(2, 1, '2023-02-10', 1500),
(3, 2, '2023-01-20', 8000),
(4, 3, '2023-04-20', 5000),
(5, 4, '2023-03-15', 2000),
(6, 4, '2023-04-02', 4000),
(7, 5, '2023-04-02', 4000),
(8, 5, '2023-05-02', 3000);

select * from loan_tbl;
select * from payment_tbl;


with LoanPaymentStatus as (
	select 
		loan_id,
		sum(amount_paid) as total_amount_paid,
		max(payment_date) as latest_payment_date
	from
		payment_tbl
	group by loan_id
	order by loan_id
)
select
	lt.loan_id,
	lt.loan_amount,
	lt.due_date,
	case
		when lt.loan_amount = lps.total_amount_paid then 1
		else 0
	end as fully_paid_flag,
	case
		when lt.loan_amount = lps.total_amount_paid and lt.due_date >= lps.latest_payment_date then 1
		else 0
	end as on_time_flag
from
	loan_tbl lt
		join
	LoanPaymentStatus lps on lt.loan_id = lps.loan_id;
