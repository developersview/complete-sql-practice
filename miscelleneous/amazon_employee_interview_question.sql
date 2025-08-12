/*
List employees who earn more than their department average.
*/

-- 𝐃𝐞𝐩𝐚𝐫𝐭𝐦𝐞𝐧𝐭𝐬 𝐓𝐚𝐛𝐥𝐞
DROP TABLE IF EXISTS Departments;
CREATE TABLE Departments(
 DeptID INT PRIMARY KEY,
 DeptName VARCHAR(50)
);

-- 𝐒𝐚𝐦𝐩𝐥𝐞 𝐃𝐞𝐩𝐚𝐫𝐭𝐦𝐞𝐧𝐭𝐬 𝐃𝐚𝐭𝐚
INSERT INTO Departments(DeptID, DeptName) VALUES
(1, 'IT'),(2, 'HR'),(3, 'Finance');

-- 𝐄𝐦𝐩𝐥𝐨𝐲𝐞𝐞𝐬 𝐓𝐚𝐛𝐥𝐞
DROP TABLE IF EXISTS Employees_Data;
CREATE TABLE Employees_Data (
 EmpID INT PRIMARY KEY,
 EmpName VARCHAR(50),
 Salary INT,
 DeptID INT
);

-- 𝐒𝐚𝐦𝐩𝐥𝐞 𝐄𝐦𝐩𝐥𝐨𝐲𝐞𝐞𝐬 𝐃𝐚𝐭𝐚
INSERT INTO Employees_Data (EmpID, EmpName, Salary, DeptID) VALUES
(101, 'Alice', 70000, 1),(102, 'Bob', 80000, 1),
(103, 'Charlie', 60000, 1),(104, 'David', 40000, 2),
(105, 'Eve', 50000, 2),(106, 'Frank', 90000, 3),
(107, 'Grace', 85000, 3), (108, 'Hank', 75000, 3);

SELECT * FROM Departments;
SELECT * FROM Employees_Data;

-- solution
WITH Dept_Avg_Salary AS (
	SELECT
		deptid, ROUND(AVG(salary), 2) AS avg_salary
	FROM
		Employees_Data
	GROUP BY deptid
)
SELECT
	e.empid,
	e.empname,
	e.salary,
	d.deptname,
	de.avg_salary AS dept_avg_salary
FROM
	Departments d
		JOIN
	Employees_Data e ON d.deptid = e.deptid
		JOIN
	Dept_Avg_Salary de ON e.deptid = de.deptid
WHERE e.salary > de.avg_salary;