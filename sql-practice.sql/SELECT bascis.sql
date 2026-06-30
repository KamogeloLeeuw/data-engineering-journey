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

--  employee_id
SELECT employee_id FROM employees
	WHERE age < 37;

--  department
SELECT first_name, age FROM employees
	WHERE department = 'Finance';

--  salary
SELECT first_name FROM employees
	WHERE salary >= 30000;

SELECT * FROM employees ORDER BY age DESC;