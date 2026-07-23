-- Month 2, Week 1: Window functions
-- ROW_NUMBER, RANK, DENSE_RANK, LAG, LEAD, FIRST_VALUE, LAST_VALUE
-- Database: retail_shop


-- ROW_NUMBER(), RANK(), DESE_RANK()
-- 1. Ranking employees by salary
SELECT employee_id, first_name, last_name, position, salary,
ROW_NUMBER() OVER(
	ORDER BY salary DESC
) AS salary_rank
FROM employees;


-- 2. Rank employees by salary with position
SELECT first_name, last_name, position, salary,
	ROW_NUMBER() OVER(
		PARTITION BY position
		ORDER BY salary DESC
	) AS postition_rank
FROM employees;


-- 3. Compare RANK() vs DENSE_RANK()
SELECT first_name, position, salary,
RANK() OVER(
	ORDER BY salary DESC
) AS salary_rank,
DENSE_RANK() OVER(
	ORDER BY salary DESC
) AS dense_salary_rank
FROM employees;


-- Employee analytics
-- 4. Finding the highest paid employee in each position
SELECT * FROM
(
	SELECT first_name, last_name, position, salary,
	RANK() OVER(
		PARTITION BY position
		ORDER BY salary DESC
	) AS salary_rank
	FROM employees
)ranked_employees
WHERE salary_rank = 1;


-- 5. Find the lowest paid employee
SELECT * FROM
(
	SELECT first_name, last_name, position,
	RANK() OVER(
		PARTITION BY position
		ORDER BY salary ASC
	) AS salary_rank
	FROM employees
)ranked_employees
WHERE salary_rank = 1;


-- LAG() & LEAD
-- 6. Comparing each employee salary 
SELECT 
	first_name, 
	last_name, 
	salary,
	LAG(salary) OVER(
		ORDER BY salary DESC
	) AS previous_salary
FROM employees;


-- 7. Compar each employee salary with the next one
SELECT 
	first_name,
	last_name,
	salary,
	LEAD(salary) OVER(
		ORDER BY salary DESC
	) AS next_salary
FROM employees;


-- FIRST_VALUE() & LAST_VALUE()
-- 8. Highest salary within each position
SELECT
	first_name,
	last_name,
	position,
	salary,
	FIRST_VALUE(salary) OVER(
		PARTITION BY position
		ORDER BY salary DESC
	) AS highest_positiion_salary
FROM employees;


-- 9. Show the lowest salary within each position
SELECT 
	first_name,
	last_name,
	position,
	salary,
	LAST_VALUE(salary) OVER(
		PARTITION BY position
		ORDER BY salary DESC
		ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
	) AS lowest_position_salary
FROM employees;


-- 10. Rank products by price within each category
SELECT
	p.product_name,
	c.category_name,
	p.price,
	RANK() OVER(
		PARTITION BY c.category_name
		ORDER BY p.price DESC
	) AS category_price_rank
FROM products p
INNER JOIN categories c
ON p.category_id = c.category_id;


-- 11. Top 3 expensive products per category
SELECT * FROM
(
	SELECT
		p.product_name,
		c.category_name,
		p.price,
		ROW_NUMBER() OVER(
			PARTITION BY c.category_name
			ORDER BY p.price DESC
		) AS product_rank
	FROM products p
	INNER JOIN categories c
	ON p.category_id = c.category_id
) ranked_products
WHERE product_rank <= 3;


-- 12. Rank customers by total spending
WITH customer_sales AS
(
	SELECT
		c.customer_id,
		c.first_name,
		c.last_name,
		SUM(oi.quantity * oi.unit_price) AS total_spent
	FROM customers c
	INNER JOIN orders o
	ON c.customer_id = o.customer_id
	INNER JOIN order_items oi
	ON o.order_id = oi.order_id
	GROUP BY
		c.customer_id,
		c.first_name,
		c.last_name
)
SELECT 
	first_name,
	last_name,
	total_spent,
	RANK() OVER(
		ORDER BY total_spent DESC
	) AS customer_rank
FROM customer_sales;


-- 13. Monthly revenue & previous month 
WITH monthly_sales AS
(
	SELECT
		DATE_TRUNC('month', o.order_date) AS month,
		SUM(oi.quantity  * oi.unit_price) AS revenue
	FROM orders o
	INNER JOIN order_items oi
	ON o.order_id = oi.order_id
	WHERE o.status = 'Completed'
	GROUP BY month
)
SELECT
	month,
	revenue,
	LAG(revenue) OVER(
		ORDER BY month
	) AS previous_month_revenue
FROM monthly_sales;


-- 14. Total revenue
SELECT
	o.order_date,
	SUM(oi.quantity * oi.unit_price) AS daily_sales,
	SUM(SUM(oi.quantity * oi.unit_price))
	OVER(
		ORDER BY o.order_date
	) AS running_total
FROM orders o
INNER JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY o.order_date
ORDER BY o.order_date;