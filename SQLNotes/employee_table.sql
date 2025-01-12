USE sqlpractice;
-- Create the Employee table
CREATE TABLE Employee (
	EmployeeID INT PRIMARY KEY,
	FirstName VARCHAR(50),
	LastName VARCHAR(50),
	Position VARCHAR(50),
	Department VARCHAR(50),
	HireDate DATE,
	Salary DECIMAL(10, 2),
	Email VARCHAR(100)
);
-- Insert data into the Employee table
INSERT INTO Employee (EmployeeID, FirstName, LastName, Position, Department, HireDate, Salary, Email)
VALUES
(1, 'John', 'Doe', 'Manager', 'Sales', '2018-01-15', 75000, 'john.doe@example.com'),
(2, 'Jane', 'Smith', 'Developer', 'IT', '2019-03-22', 85000, 'jane.smith@example.com'),
(3, 'Alice', 'Brown', 'Analyst', 'Finance', '2020-07-19', 65000, 'alice.brown@example.com'),
(4, 'Bob', 'Davis', 'Consultant', 'HR', '2021-05-10', 70000, 'bob.davis@example.com'),
(5, 'Eve', 'White', 'Assistant', 'Admin', '2017-12-05', 45000, 'eve.white@example.com');