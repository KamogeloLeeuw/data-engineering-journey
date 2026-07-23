-- Week 3: JOINS

DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(50),
    manager VARCHAR(100)
);

INSERT INTO departments (department_name, manager)
VALUES
('IT', 'John Smith'),
('Finance', 'Sarah Jones'),
('HR', 'David Brown'),
('Marketing', 'Emma Wilson'),
('Sales', 'Michael Green');


ALTER TABLE employees
ADD COLUMN department_id INT;

UPDATE employees
SET department_id = 1
WHERE department = 'IT';

UPDATE employees 
SET department_id = 2
WHERE department = 'Finance';

UPDATE employees
SET department_id = 3
WHERE department = 'HR';

UPDATE employees
SET department_id = 4
WHERE department = 'Marketing';

UPDATE employees
SET department_id = 5
WHERE department = 'Sales';


ALTER TABLE employees
ADD CONSTRAINT fk_department
FOREIGN KEY (department_id)
REFERENCES departments(department_id);


-- INNER JOIN
SELECT * FROM employees
INNER JOIN departments
ON employees.department_id = departments.department_id;

-- using ALIASES
SELECT employees.first_name, departments.department_name FROM employees
INNER JOIN departments
ON employees.department_id = departments.department_id;


-- LEFT JOIN
INSERT INTO departments
(department_name, manager)
VALUES ('Legal', 'Lethabo Ramaphosa');

SELECT e.first_name, d.department_name FROM departments d
LEFT JOIN employees e
ON d.department_id = e.department_id;



SELECT * FROM employees;

-- RIGHT JOIN
SELECT e.first_name, d.department_name FROM employees e
RIGHT JOIN departments d 
ON e.department_id = d.department_id;

-- finding null departments
SELECT d.department_name FROM departments d
LEFT JOIN employees e
ON d.department_id = e.department_id
WHERE e.employee_id IS NULL;

-- COUNT employees 
SELECT d.department_name, COUNT(e.employee_id) AS employee_count
FROM departments d
LEFT JOIN employees e 
ON d.department_id = e.department_id
GROUP BY d.department_name
ORDER BY employee_count DESC;


-- Project table
CREATE TABLE projects (
    project_id SERIAL PRIMARY KEY,
    project_name VARCHAR(100),
    employee_id INT,
    budget DECIMAL(10,2),
    start_date DATE,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);


INSERT INTO projects (project_name, employee_id, budget, start_date) VALUES
('Payroll System', 1, 150000, '2025-01-15'),
('Company Website', 2, 85000, '2025-02-10'),
('Inventory App', 3, 250000, '2024-10-01'),
('Financial Dashboard', 4, 175000, '2025-03-05'),
('Recruitment Portal', 5, 120000, '2024-11-20'),
('Network Upgrade', 2, 95000, '2025-04-15'),
('Cloud Migration', 3, 400000, '2025-05-01'),
('Marketing Campaign', 10, 60000, '2025-06-01');

SELECT * FROM projects;

-- Inner join
SELECT e.first_name, e.last_name, d.department_name FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id;

SELECT e.first_name, d.department_name, d.manager FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id;

SELECT e.first_name, e.salary, d.department_name FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id;

SELECT e.first_name, e.salary, d.department_name FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id
WHERE e.salary > 30000;

SELECT p.project_name, e.first_name, e.last_name FROM projects p
INNER JOIN employees e
ON p.employee_id = e.employee_id;

-- LEFT JOIN
SELECT d.department_name, e.first_name FROM departments d
LEFT JOIN employees e
ON d.department_id = e.department_id;

SELECT e.first_name, e.last_name FROM employees e
LEFT JOIN projects p
ON e.employee_id = p.employee_id
WHERE p.project_id IS NULL;

SELECT e.first_name, e.last_name FROM employees e
LEFT JOIN projects p
ON e.employee_id = p.employee_id
WHERE p.project_id IS NULL;

SELECT d.department_name FROM departments d
LEFT JOIN employees e
ON d.department_id = e.department_id
WHERE e.employee_id IS NULL;

SELECT d.department_name,
	COUNT(e.employee_id) AS employee_count
FROM departments d
LEFT JOIN employees e
ON d.department_id = e.department_id
GROUP BY d.department_name;

-- Right join
SELECT e.first_name, d.department_name FROM employees e
RIGHT JOIN departments d
ON e.department_id = d.department_id;

SELECT e.first_name, p.project_name FROM employees e
RIGHT JOIN projects p
ON e.employee_id = p.employee_id;

SELECT d.manager, e.first_name FROM employees e
RIGHT JOIN departments d
ON e.department_id = d.department_id;

SELECT p.project_name, p.budget, e.first_name FROM employees e
RIGHT JOIN projects p
ON e.employee_id = p.employee_id;


-- JOIN ALL 3 TABLES
SELECT e.first_name, d.department_name, d.manager, p.project_name, p.budget FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id
INNER JOIN projects p
ON e.employee_id = p.employee_id;

