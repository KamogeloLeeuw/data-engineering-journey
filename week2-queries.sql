-- Week 2: GROUP BY and aggregate functions
-- Builds on the employees table created in week1-queries.sql
-- Run week1-queries.sql first to create the table and initial data

INSERT INTO employees (first_name, last_name, age, department, salary, hire_date) VALUES
('John', 'Smith', 31, 'IT', 42000, '2023-01-15'),
('Sarah', 'Jones', 28, 'HR', 26000, '2022-04-12'),
('David', 'Brown', 40, 'Finance', 48000, '2021-08-20'),
('Emma', 'Wilson', 24, 'Marketing', 22000, '2024-02-01'),
('James', 'Taylor', 35, 'IT', 55000, '2020-09-18'),
('Olivia', 'Martin', 29, 'Marketing', 30000, '2023-07-10'),
('Daniel', 'Mokoena', 38, 'Finance', 62000, '2019-11-25'),
('Grace', 'Nkosi', 27, 'HR', 28000, '2024-05-14'),
('Liam', 'Peters', 33, 'IT', 45000, '2022-12-03'),
('Sophia', 'Naidoo', 26, 'Marketing', 27000, '2025-01-20'),
('Ethan', 'Johnson', 41, 'Finance', 70000, '2018-06-05'),
('Ava', 'Williams', 30, 'HR', 34000, '2021-03-17'),
('Noah', 'Miller', 36, 'IT', 52000, '2020-10-08'),
('Mia', 'Anderson', 25, 'Marketing', 24000, '2024-09-01'),
('Lucas', 'Moore', 39, 'Finance', 58000, '2019-04-22'),
('Zanele', 'Dlamini', 32, 'HR', 36000, '2022-07-11');

-- Practice aggregate functions
-- Amount of employees
SELECT COUNT(*) AS total_employees FROM employees;
-- Average age
SELECT AVG(age) AS average_age FROM employees;
-- Average salary
SELECT AVG(salary) AS average_salary FROM employees;
-- MIN/MAX Salary
SELECT MIN(salary) AS lowest_salary FROM employees;
-- Payroll
SELECT SUM(salary) AS total_payroll FROM employees;

-- Practice GROUP BY
-- Number of employees per department
SELECT department, 
	COUNT(*) AS employee_count
FROM employees
GROUP BY department;
-- Average salary
SELECT department,
	AVG(salary) AS average_salary
FROM employees
GROUP BY department;
-- Salary per department
SELECT department,
	MAX(salary) AS highest_salary
FROM employees
GROUP BY department;
-- Total salary paid per department
SELECT department,
	SUM(salary) AS total_salary
FROM employees
GROUP BY department;

-- Departments with more than 5 employees (HAVING)
SELECT department,
	COUNT(*) AS employee_count
FROM employees
GROUP BY department
HAVING COUNT(*) > 5;

-- Departments where average salary exceeds 35000 (HAVING)
SELECT department,
	AVG(salary) AS average_salary
FROM employees
GROUP BY department
HAVING AVG(salary) > 35000;