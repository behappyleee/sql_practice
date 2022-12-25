-- LINK : https://en.wikibooks.org/wiki/SQL_Exercises/Employee_management
-- 2.1 Select the last name of all employees.
SELECT name FROM employees;

-- 2.2 Select the last name of all employees, without duplicates.
SELECT DISTINCT LastName FROM employees;

-- 2.3 Select all the data of employees whose last name is "Smith".
SELECT SSN, Name, LastName, Department FROM employees e WHERE e.LastName = 'Smith';

-- 2.4 Select all the data of employees whose last name is "Smith" or "Doe".
SELECT SSN, Name, LastName, Department FROM employees e WHERE e.LastName = 'Smith' OR e.LastName = 'Doe';

SELECT * FROM employees e;

-- 2.5 Select all the data of employees that work in department 14.
SELECT SSN, Name, LastName, Department FROM employees e WHERE e.Department = 14;

-- 2.6 Select all the data of employees that work in department 37 or department 77.
SELECT SSN, Name, LastName, Department FROM employees e WHERE e.Department = 37 OR e.Department = 77;

-- 2.7 Select all the data of employees whose last name begins with an "S".
SELECT SSN, Name, LastName, Department FROM employees WHERE employees.LastName LIKE 'S%';

SELECT * FROM employees e;
SELECT * FROM departments d;
-- 2.8 Select the sum of all the departments' budgets.
SELECT sum(d.Budget) FROM departments d; 

-- 2.9 Select the number of employees in each department (you only need to show the department code and the number of employees).
SELECT count(SSN), e.Department FROM employees e GROUP BY e.Department;

-- 2.10 Select all the data of employees, including each employee's department's data.
SELECT e.SSN, e.Name, e.LastName, e.Department, d.Name , d.Budget FROM employees e INNER JOIN departments d ON e.Department = d.Code;

-- 2.11 Select the name and last name of each employee, along with the name and budget of the employee's department.
SELECT e.Name, e.LastName, d.name, d.budget FROM employees e INNER JOIN departments d ON e.department = d.code;  

-- 2.12 Select the name and last name of employees working for departments with a budget greater than $60,000.
SELECT e.name, e.lastName, d.budget FROM employees e INNER JOIN departments d ON e.department = d.code WHERE d.budget > 60000; 

-- 2.13 Select the departments with a budget larger than the average budget of all the departments.
SELECT d.Code, d.Name, d.Budget FROM departments d WHERE d.budget > 
(
SELECT AVG(d2.budget
) FROM departments d2);

-- 2.14 Select the names of departments with more than two employees.

SELECT count(e.SSN), e.Department FROM employees e GROUP BY e.Department HAVING count(e.SSN) > 2;

SELECT d.name FROM departments d WHERE d.code IN (
	SELECT e.department 
	  FROM employees e
  GROUP BY e.department
     HAVING count(e.SSN) > 2	  
);

SELECT * FROM departments d;

-- TODO 여기서부터 하지 못함 TEST 하여 보기 !!!!!!!!!!!!!!!!!!!!!
-- 2.15 Very Important - Select the name and last name of employees working for departments with second lowest budget.


-- SELECT @ROWNUM:=@ROWNUM+1 AS ROW, e.SSN FROM employees e WHERE (@ROWNUM:=0)=0;

-- 2.16  Add a new department called "Quality Assurance", with a budget of $40,000 and departmental code 11. 
INSERT INTO departments (code, name, budget) VALUES(11, 'Quality Assurance', 40000);

-- And Add an employee called "Mary Moore" in that department, with SSN 847-21-9811.
INSERT INTO employees (SSN, NAME, LASTNAME, Department) VALUES(847-21-9811, 'Mary', 'Moore', 11);
UPDATE employees SET SSN = 847219811 WHERE name = 'Mary';


-- 2.17 Reduce the budget of all departments by 10%.
UPDATE departments SET budget = (budget * 0.90);

-- 2.18 Reassign all employees from the Research department (code 77) to the IT department (code 14).
UPDATE employees SET department = 14 WHERE department = 77;

-- 2.19 Delete from the table all employees in the IT department (code 14).
DELETE FROM employees WHERE department = 14;

-- 2.20 Delete from the table all employees who work in departments with a budget greater than or equal to $60,000.
DELETE FROM employees WHERE department IN (
	SELECT code 
	  FROM departments d
	 WHERE d.budget >= 60000 
);

-- 2.21 Delete from the table all employees.
DELETE FROM employees;
