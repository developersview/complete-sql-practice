drop table if exists transactions;

create table transactions (
	user_id INT,
	spend FLOAT,
	transaction_date TIMESTAMP
);

insert into transactions (user_id, spend, transaction_date) values 
(111, 100.50, '2022-01-08 12:00:00'),
(111, 55.00, '2022-01-10 12:00:00'),
(121, 36.00, '2022-01-18 12:00:00'),
(145, 24.99, '2022-01-26 12:00:00'),
(111, 89.60, '2022-02-05 12:00:00'),
(145, 56.79, '2022-02-21 12:00:00'),
(134, 186.50, '2022-01-12 12:00:00'),
(145, 120.99, '2022-03-10 12:00:00');


select * from transactions;

-- find the third transaction for every user 
with transaction_rank as (
	select 
		user_id, spend, transaction_date,
		dense_rank() over (partition by user_id order by transaction_date) as rnk
	from
		transactions
)
select
	user_id, spend, transaction_date
from
	transaction_rank
where
	rnk = 3;

