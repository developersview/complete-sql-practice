drop table if exists employees;

create table employees (
	id INT,
	name VARCHAR(50),
	salary FLOAT
);

insert into employees (id, name, salary) values
(1, 'Alice', 5000),
(2, 'Bob', 7000),
(3, 'Charlie', 6000),
(4, 'David', 7000),
(5, 'Eve', 8000),
(6, 'Frank', 6000),
(7, 'Grace', 9000);

select * from employees;

-- find nth highest salary
select distinct 
	salary
from
	(
		select *, dense_rank() over (order by salary desc) as rnk
		from employees
	)
where rnk = 3;