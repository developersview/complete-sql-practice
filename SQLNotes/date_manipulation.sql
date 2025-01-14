-- How would you extract just the date from a hire date field?
SELECT
	EmployeeID, 
	HireDate,
	CAST(HireDate AS DATE) AS HireDateOnly
FROM
	Employee;

-- How can you break down the hire date into year, month, and day components?
SELECT
	EmployeeID, 
	HireDate,
	YEAR(HireDate) AS HireYear,
	MONTH(HireDate) AS HireMonth,
	DAY(HireDate) AS HireDay
FROM
	Employee;

--  What’s the best way to calculate the number of days an employee has been with the company?
SELECT
	EmployeeID, 
	HireDate,
	DATEDIFF(DAY, HireDate, GETDATE()) AS DaysWithCompany,
	DATEDIFF(MONTH, HireDate, GETDATE()) AS MonthsWithCompany,
	DATEDIFF(YEAR, HireDate, GETDATE()) AS YearsWithCompany,
	DATEDIFF(WEEK, HireDate, GETDATE()) AS WeeksWithCompany
FROM
	Employee;

-- How would you add a year to the hire date for tracking anniversaries?
SELECT
	EmployeeID, 
	HireDate,
	DATEADD(YEAR, 1, HireDate) AS NextAnniversary
FROM
	Employee;

-- Find Employees Hired in a Specific Month (e.g., January)
SELECT
	EmployeeID,
	CONCAT(FirstName, ' ', LastName) AS name,
	Position,
	Department,
	HireDate
FROM
	Employee
WHERE
	MONTH(HireDate) = 1;

-- Determine the Weekday of the Hire Date
SELECT
	EmployeeID,
	HireDate,
	DATENAME(WEEKDAY, HireDate) AS HireDayOfWeek
FROM
	Employee;

-- Find the Last Working Day of the Current Month
SELECT EOMONTH(GETDATE()) AS LastWorkingDay;
	