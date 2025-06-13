drop table if exists employee_details;

create table employee_details (
	gender VARCHAR(20),
	age INT
);

insert into employee_details (gender, age) values
('M', 25),
('f', 17),
(null, 65);

select * from employee_details;

select
	case 
		when upper(gender) = 'M' then 'Male' 
		when upper(gender) = 'F' then 'Female'
		else 'Unknown'
	end as gender,
	case
		when age <= 18 then 'Teen'
		when age between 19 and 59 then 'Adult'
		else 'Senior'
	end as age
	
from
	employee_details;
