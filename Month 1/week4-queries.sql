-- WEEK 4
-- Subqueries WHERE

-- employees average age
SELECT first_name, last_name, age FROM employees
WHERE age >
(
SELECT AVG(age)
FROM employees
);

-- employee salary < avg
SELECT first_name, last_name, salary FROM employees
WHERE salary < 
(
SELECT AVG(salary)
FROM employees
);
 
-- pojects above budget
SELECT project_name, budget FROM projects
WHERE budget > 
(
SELECT AVG(budget)
FROM projects
);

-- employees hired
SELECT first_name, last_name, hire_date FROM employees
WHERE hire_date > 
(
SELECT MAX(hire_date)
FROM employees
WHERE department_id =
	(
		SELECT department_id
		FROM departments
		WHERE department_name = 'Finance'
	)
);

-- Subqueries FROM
-- avg age per department
SELECT d.department_name, a.average_age FROM 
(
	SELECT department_id,
		AVG(age) AS average_age
	FROM employees
	GROUP BY department_id
) a
INNER JOIN departments d
ON a.department_id = d.department_id;

-- total salary per department
SELECT d.department_name, s.total_salary FROM
(
	SELECT department_id,
		SUM(salary) AS total_salary
	FROM employees
	GROUP BY department_id
) s
INNER JOIN departments d
ON s.department_id = d.department_id;

-- number of projects per employee
SELECT e.first_name, p.project_count FROM
(
	SELECT employee_id,
		COUNT(*) AS project_coount
	FROM projects
	GROUP BY employee_id
) p
INNER JOIN employees e
ON p.employee_id = e.employee_id;

-- avg project budget
SELECT e.first_name, a.average_budget FROM
(
	SELECT employee_id,
		AVG(budget) AS average_budget
	FROM projects
	GROUP BY employee_id
) a
INNER JOIN employees e
ON a.employee_id = e.employee_id;

-- Correlated Subqueries
-- highest paid employee per department
SELECT e.first_name, e.last_name, e.salary FROM employees e
WHERE salary = 
(
	SELECT MAX(salary)
	FROM employees
	WHERE department_id = e.department_id
);

-- oldesr employeee per department
SELECT e.first_name, e.last_name, e.age FROM employees e
WHERE age =
(
	SELECT MAX(age)
	FROM employees
	WHERE department_id = e.department_id
);

-- employee salary > department avg
SELECT e.first_name, e.last_name, e.salary FROM employees e
WHERE salary >
(
	SELECT AVG(salary)
	FROM employees
	WHERE department_id = e.department_id
);

-- employee hire
SELECT e.first_name, e.last_name, e.hire_date
FROM employees e
WHERE hire_date =
(
    SELECT MIN(hire_date)
    FROM employees
    WHERE department_id = e.department_id
);

-- CASE WHEM
-- category salary
SELECT first_name, salary,
CASE 
	WHEN salary >= 60000 THEN 'HIGH'
	WHEN salary >= 30000 THEN 'MEDIUM'
	ELSE 'LOW'
END AS salary_category
FROM employees;

-- category ages
SELECT first_name, age,
CASE 
	WHEN age < 25 THEN 'YOUNG'
	WHEN age <= 35 THEN 'ADULT'
	ELSE 'SENIOR'
END AS age_category
FROM employees;

-- category project budgets
SELECT project_name, budget,
CASE
    WHEN budget >= 250000 THEN 'HIGH'
    WHEN budget >= 100000 THEN 'MEDIUM'
    ELSE 'LOW'
END AS budget_category
FROM projects;

-- String functions
-- display name
SELECT 
CONCAT (first_name, ' ', last_name) AS full_name
FROM employees;


-- show all names in uppercase
SELECT
UPPER(first_name) AS first_name,
UPPER(last_name) AS last_name
FROM employees;

-- employees whose surnames is M
SELECT * FROM employees
WHERE last_name LIKE 'M%';

-- display 1st 2 letter of surname
SELECT last_name,
LEFT(last_name, 2) AS initials
FROM employees;

-- display length of full name
SELECT 
CONCAT(first_name, ' ', last_name) AS full_name,
LENGTH(CONCAT(first_name, ' ', last_name)) AS name_length
FROM employees;


-- DATE function
-- employee hired
SELECT * FROM employees
WHERE hire_date > '2023-12-31';

-- employee hired
SELECT * FROM employees
WHERE EXTRACT(MONTH FROM hire_date) = 3;

-- employees hired each year
SELECT
EXTRACT(YEAR FROM hire_date) AS hire_year,
COUNT(*) AS total_employees
FROM employees
GROUP BY hire_year
ORDER BY hire_year;

-- Oldest employee hired
SELECT * FROM employees
WHERE hire_date = 
(
	SELECT MIN(hire_date)
	FROM employees
);

-- latest employee hire
SELECT * FROM employees
WHERE hire_date =
(
	SELECT MAX(hire_date)
	FROM employees
);

-- CTEs

-- avg salary
WITH average_salary AS
(
	SELECT AVG(salary) AS avg_salary
	FROM employees
)
SELECT first_name, salary FROM employees, average_salary
WHERE salary > avg_salary;

-- employees per department
WITH employee_count AS 
(
	SELECT department_id,
	COUNT(*) AS total
	FROM employees
	GROUP BY department_id
)
SELECT d.department_name, employee_count.total
FROM employee_count
INNER JOIN departments d
ON employee_count.department_id = d.department_id;

-- avg project budget
WITH avg_budget AS
(
	SELECT employee_id, AVG(budget) AS average_budget
	FROM projects
	GROUP BY employee_id
)
SELECT e.first_name, avg_budget.average_budget
FROM avg_budget
INNER JOIN employees e
ON avg_budget.employee_id = e.employee_id;

-- Highest salary in each department
WITH highest_salary AS
(
    SELECT
        department_id,
        MAX(salary) AS highest_salary
    FROM employees
    GROUP BY department_id
)
SELECT
d.department_name,
highest_salary.highest_salary
FROM highest_salary
INNER JOIN departments d
ON highest_salary.department_id = d.department_id;


-- Multiple CTEs
WITH average_salary AS 
(
	SELECT department_id, AVG(salary) AS avg_salary
	FROM employees
	GROUP BY department_id
),
employee_count AS
(
	SELECT department_id, COUNT(*) AS total_employees
	FROM employees
	GROUP BY department_id
)
SELECT 
d.department_name, 
average_salary.avg_salary, 
employee_count.total_employees 
FROM departments d
INNER JOIN average_salary
ON d.department_id = average_salary.department_id
INNER JOIN employee_count
ON d.department_id = employee_count.department_id;