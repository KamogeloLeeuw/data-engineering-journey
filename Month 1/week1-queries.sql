DROP TABLE IF EXISTS employees;

CREATE TABLE IF NOT EXISTS employees(
	employee_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	age INT,
	department VARCHAR(50),
	salary DECIMAL(10, 2),
	hire_date DATE
);

SELECT * FROM employees;

INSERT INTO employees (first_name, last_name, age, department, salary, hire_date) VALUES
('Lisa', 'Van Wyk', 29, 'Finance', 29500, '2025-03-15'),
('Kamogelo', 'Leeuw', 23, 'IT', 15000, '2026-11-03'),
('Frank', 'Smith', 45, 'IT', 66000, '2022-06-29'),
('Kevin', 'Stones', 22, 'Finance', 15500, '2026-02-27'),
('Mike', 'Smith', 27, 'HR', 30000, '2025-12-07'),
('Lisa', 'Van der Merwe', 25, 'Finance', 27000, '2024-05-05'),
('Tshepo', 'Mashaba', 30, 'Finance', 33000, '2022-05-01'),
('Sipho', 'Mashapu', 45, 'HR', 50000, '2022-03-22'),
('Karabo', 'Leso', 35, 'IT', 37500, '2023-10-05');

-- first name, last name, department
SELECT first_name, last_name, department FROM employees;

-- display employees in different department
SELECT * FROM employees
	WHERE department = 'Finance';

-- salary for each employee 
SELECT first_name, last_name, salary FROM employees
	ORDER BY salary DESC;

-- emplyoee salary filter 
SELECT first_name, last_name, department, salary FROM employees
	WHERE salary <= 40000
	AND department = 'HR';

-- annual salary 
SELECT first_name, last_name, salary * 12 AS annual_salary
FROM employees;

-- employee hire date
SELECT * FROM employees
	WHERE hire_date < '2025-03-06'
	ORDER BY hire_date;
