drop table if exists salesperson;

create table salesperson (
	salesperson_name VARCHAR(50),
	sales_date DATE,
	amount FLOAT
);

insert into salesperson (salesperson_name, sales_date, amount) values
('Rahul', '2024-01-01', 300),
('Rahul', '2024-01-03', 400),
('Rahul', '2024-01-05', 500),
('Rahul', '2024-01-07', 200),
('Mohit', '2024-01-02', 600),
('Mohit', '2024-01-04', 500),
('Mohit', '2024-01-07', 300);

select * from salesperson;


-- using two ctes
with cummulative_amount as (
	select
		*,
		SUM(amount) over (partition by salesperson_name order by sales_date) as running_amount
	from
		salesperson
),
ranked_cummulative_amount as (
	select
		*,
		ROW_NUMBER() over (partition by salesperson_name order by sales_date) as rnk
	from
		cummulative_amount 
	where running_amount >= 1000
)
select
	salesperson_name, 
	sales_date
from
	ranked_cummulative_amount
where rnk = 1
order by sales_date desc;


-- using one cte and group by
with cummulative_amount as (
	select
		*,
		SUM(amount) over (partition by salesperson_name order by sales_date) as running_amount
	from
		salesperson
)
select
	salesperson_name, 
	min(sales_date) as sales_date
from
	cummulative_amount
where running_amount >= 1000
group by salesperson_name
order by sales_date desc;
