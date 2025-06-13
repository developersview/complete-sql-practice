drop table if exists orders_tbl;

create table orders_tbl (
	order_id INT not null,
	customer_id VARCHAR(50),
	delivery_date DATE
);

insert into orders_tbl (order_id, customer_id, delivery_date) values
(1, '101', '5/1/2024'),
(1, null, '5/2/2024'),
(1, '102', null),
(1, null, null),
(1, '103', '5/3/2024');

select * from orders_tbl;

-- how many record will return when we execute these query
select * from orders_tbl where customer_id <> '101';

select * from orders_tbl where customer_id is not null;

select * from orders_tbl where customer_id != null;

select * from orders_tbl where customer_id <> null;