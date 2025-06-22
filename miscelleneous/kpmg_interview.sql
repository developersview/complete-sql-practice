drop table if exists orders;

create table orders(
	order_id INT,
	customer_id INT,
	order_date DATE,
	amount DECIMAL
);

INSERT INTO orders (order_id, customer_id, order_date, amount) VALUES
(1, 101, '2025-06-01', 150.00),
(2, 102, '2025-06-02', 300.00),
(3, 101, '2025-06-03', 200.00),
(4, 103, '2025-06-04', 400.00),
(5, 104, '2025-06-05', 250.00),
(6, 102, '2025-06-06', 500.00),
(7, 105, '2025-06-07', 100.00),
(8, 104, '2025-06-08', 350.00),
(9, 103, '2025-06-09', 300.00),
(10, 106, '2025-06-10', 450.00);

select * from orders;

-- with limit
select
	customer_id,
	sum(amount) as total_amount
from
	orders
group by customer_id
order by total_amount desc
limit 3;


-- without limit or offset
with ranked_total_amount as (
	select
		customer_id,
		sum(amount) as total_amount,
		DENSE_RANK() OVER(ORDER BY SUM(amount) DESC) as rnk
	from
		orders
	group by customer_id
)
select 
	customer_id, total_amount
from ranked_total_amount
where rnk <= 3;




select * from orders
WHERE 1=1 AND 1=0 OR 1=1 AND 1=1;
