drop table if exists orders;
CREATE TABLE orders (
 order_id INT,
 customer_name VARCHAR(50)
);

INSERT INTO orders VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie'),
(4, 'David'),
(5, 'Emma');

drop table if exists INVOICES;
CREATE TABLE invoices (
 invoice_id INT,
 order_id INT,
 status VARCHAR(20)
);

INSERT INTO invoices VALUES
(101, 1, 'Paid'),
(102, 2, 'Pending'),
(103, 4, 'Paid');

select * from orders;
select * from invoices;

select 
	o.order_id,
	o.customer_name,
	coalesce(i.status, 'No invoice') as status
from orders o
		left join
	 invoices i on o.order_id = i.order_id
where
	i.status <> 'Paid' or i.status is null;