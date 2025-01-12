USE sqlpractice;

SELECT * FROM Employee;

-- How can you display the full name of each employee by combining their first and last names?
SELECT
	EmployeeID,
	CONCAT(FirstName, ' ', LastName) AS full_name
FROM
	Employee;

-- How would you extract the first three characters of an employee's first name
SELECT
	EmployeeID,
	SUBSTRING(FirstName, 1, 3) AS first_names_part
FROM
	Employee;

-- How could you extract the last three characters of a job title?
SELECT
	EmployeeID,
	SUBSTRING(Position, LEN(Position) - 2, 3) AS first_names_part
FROM
 Employee;

-- How can you pull a department name starting from the second character?
SELECT
	EmployeeID,
	SUBSTRING(Department, 2, LEN(Department)) AS first_names_part
FROM
 Employee;

-- How would you find the length of each employee's first name to ensure it meets specific criteria?
SELECT
	EmployeeID,
	FirstName, 
	LEN(FirstName) AS first_name_length
FROM
	Employee;

-- How can you convert first names to uppercase for consistency? 
-- How would you convert last names to lowercase, perhaps for generating email addresses?
SELECT
	EmployeeID,
	FirstName, 
	UPPER(FirstName) AS FirstNameUpper,
	LastName,
	LOWER(LastName) AS LastNameLower
FROM
	Employee;

-- How would you update all occurrences of the word "Manager" to "Lead" in job titles?
-- How could you replace "IT" with "Technology" in department names? 
-- How would you replace spaces with hyphens in full names for URL-friendly formatting?
SELECT 
	EmployeeID,
	CONCAT(FirstName, '-', LastName) AS FullNameWithDash,
	REPLACE(Position, 'Manager', 'Lead') AS NewPosition,
	REPLACE(Department, 'IT', 'Technology') AS NewDepartment
FROM
	Employee;

-- 𝐄𝐦𝐚𝐢𝐥 𝐌𝐚𝐬𝐤𝐢𝐧𝐠: What’s the best way to mask an email address so that only the first three characters 
-- and the domain are visible, keeping the rest private?
SELECT
	EmployeeID,
	Email,
	STUFF(Email, 4, CHARINDEX('@', Email) - 4, REPLICATE('*', CHARINDEX('@', Email) - 4)) AS MaskedEmail
FROM
	Employee;