drop table if exists employee_tbl;

create table employee_tbl (
	id INT primary key,
	name VARCHAR(20),
	email VARCHAR(20),
	phone INT
);

insert into employee_tbl (id, name, email, phone) values 
(1, 'Rahul', 'tieegi@odshvh.com', 0123456895),
(2, 'Ajay', null, null),
(3, null, 'abc@xyz.com', null);

select * from employee_tbl;

select
	SUM(
		case
			when id is null then 1
			else 0
		end	
	) as id,
	SUM(
		case
			when name is null then 1
			else 0
		end
	) as name,
	SUM(
		case
			when email is null then 1
			else 0
		end
		
	) as email,
	SUM(
		case
			when phone is null then 1
			else 0
		end
	) as phone
from
	employee_tbl;
	