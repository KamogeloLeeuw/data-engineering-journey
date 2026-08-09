-- ============================================================
-- MONTH 2 - WEEK 2
-- Advanced SQL & Query Performance
--
-- Learning Outcomes:
-- 1. Run EXPLAIN ANALYZE on retail_shop queries
-- 2. Understand Sequential Scan vs Index Scan
-- 3. Understand why indexes improve query performance
-- 4. Understand when indexes are not useful
-- 5. Create and test different types of indexes
-- ============================================================


-- Note: tables in this database are small (under 30 rows each)
-- PostgreSQL's query planner correctly chooses Seq Scan over Index Scan
-- for small tables because the index overhead isn't worth it at this scale
-- On production tables with thousands or millions of rows, these same
-- indexes would trigger Index Scans and significantly reduce query cost


-- ============================================================
-- EXPLAIN ANALYZE
-- ============================================================

-- 1. Price query
EXPLAIN ANALYZE
SELECT product_name, price
FROM products
WHERE price > 1000
ORDER BY price DESC;

-- Result: Seq Scan on products, cost=0.00..1.15, execution time=0.911ms


-- 2. Customers from Johannesburg
EXPLAIN ANALYZE
SELECT first_name, last_name, email
FROM customers
WHERE city = 'Johannesburg';

-- Result: Seq Scan on customers, cost=0.00..1.12, execution time=0.067ms


-- 3. Orders from a customer
EXPLAIN ANALYZE
SELECT order_id, customer_id, order_date, status
FROM orders
WHERE customer_id = 1;

-- Result: Seq Scan on orders, cost=0.00..1.15, execution time=0.036ms


-- ============================================================
-- SEQUENTIAL SCAN
-- ============================================================

EXPLAIN
SELECT *
FROM products;

-- Result: Seq Scan on products, cost=0.00..1.12, rows=12
-- Observation: PostgreSQL scan the entire product table


-- ============================================================
-- CREATE INDEXES
-- ============================================================


-- ============================================================
-- 1. PRODUCT PRICE INDEX
-- ============================================================

-- Run the query BEFORE creating the index and record the result

EXPLAIN ANALYZE
SELECT product_name, price
FROM products
WHERE price > 1000;

-- Before index: Seq Scan on products, cost=0.00..1.15

-- Create Index
CREATE INDEX idx_products_price
ON products(price);


EXPLAIN ANALYZE
SELECT product_name, price
FROM products
WHERE price > 1000;

-- After index: Seq Scan on products, cost=0.00..1.15


-- ============================================================
-- 2. ORDER DATE INDEX
-- ============================================================

-- Run the query BEFORE creating the index and record the result

EXPLAIN ANALYZE
SELECT order_id, customer_id, order_date, status
FROM orders
WHERE order_date >= '2024-04-01';

-- Before index: Seq Scan on orders, cost=0.00..1.15

-- Create Index
CREATE INDEX idx_orders_order_date
ON orders(order_date);


EXPLAIN ANALYZE
SELECT order_id, customer_id, order_date, status
FROM orders
WHERE order_date >= '2024-04-01';

-- After index: Seq Scan on orders, cost=0.00..1.15


-- ============================================================
-- 3. EMPLOYEE SALARY INDEX
-- ============================================================

-- Run the query BEFORE creating the index and record the result

EXPLAIN ANALYZE
SELECT first_name, last_name, position, salary
FROM employees
WHERE salary > 20000;

-- Before index: Seq Scan on employees, cost=0.00..12.50

-- Create Index
CREATE INDEX idx_employees_salary
ON employees(salary);


EXPLAIN ANALYZE
SELECT first_name, last_name, position, salary
FROM employees
WHERE salary > 2000;

-- After index: Seq Scan on employees, cost=0.00..1.16


-- ============================================================
-- COMPOSITE INDEX
-- ============================================================

-- Run the query BEFORE creating the index and record the result

EXPLAIN ANALYZE
SELECT order_id, customer_id, order_date, status
FROM orders
WHERE customer_id = 1
AND order_date >= '2024-01-01';

-- Before index: Seq Scan on orders, cost=0.00..1.18

-- Create Composite Index
CREATE INDEX idx_orders_customer_date
ON orders(customer_id, order_date);


EXPLAIN ANALYZE
SELECT order_id, customer_id, order_date, status
FROM orders
WHERE customer_id = 1
AND order_date >= '2024-01-01';

-- After index: Seq Scan on orders , cost=0.00..1.18


-- ============================================================
-- PARTIAL INDEX
-- PostgreSQL equivalent of a filtered index
-- ============================================================

-- Run the query BEFORE creating the index and record the result

EXPLAIN ANALYZE
SELECT order_id, order_date, status
FROM orders
WHERE status = 'Completed'
AND order_date >= '2024-01-01';

-- Before index: Seq Scan on orders, cost=0.00..1.18

-- Create Partial Index
CREATE INDEX idx_completed_orders_date
ON orders(order_date)
WHERE status = 'Completed';


EXPLAIN ANALYZE
SELECT order_id, order_date, status
FROM orders
WHERE status = 'Completed'
AND order_date >= '2024-01-01';

-- After index: Seq Scan on orders, cost=0.00..1.18


-- ============================================================
-- FULL-TEXT INDEX
-- ============================================================

-- Add description column
ALTER TABLE products
ADD COLUMN description TEXT;


-- Add product descriptions
UPDATE products
SET description = CASE product_id
    WHEN 1 THEN 'Affordable Samsung smartphone with large display'
    WHEN 2 THEN 'HP laptop suitable for work and study'
    WHEN 3 THEN 'Wireless Bluetooth earbuds with charging case'
    WHEN 4 THEN 'Comfortable cotton men t-shirt'
    WHEN 5 THEN 'Women denim jeans'
    WHEN 6 THEN 'Running shoes for training and exercise'
    WHEN 7 THEN 'Traditional South African rooibos tea'
    WHEN 8 THEN 'Instant coffee for home and office'
    WHEN 9 THEN 'A4 printing paper for office use'
    WHEN 10 THEN 'Ballpoint pens for school and office'
    WHEN 11 THEN 'Ergonomic office chair'
    WHEN 12 THEN 'Desk lamp for home and office'
END;


EXPLAIN ANALYZE
SELECT product_id, product_name, description
FROM products
WHERE to_tsvector('english', description)
      @@ to_tsquery('english', 'office');

-- Before index: Seq Scan on products, cost=0.00..4.15

-- Create Full-Text Index
CREATE INDEX idx_products_description_fts
ON products
USING GIN (
    to_tsvector('english', description)
);

EXPLAIN ANALYZE
SELECT product_id, product_name, description
FROM products
WHERE to_tsvector('english', description)
      @@ to_tsquery('english', 'office');

-- After index: Seq Scan on products, cost=0.00..4.15


-- ============================================================
-- CHECK CREATED INDEXES
-- ============================================================

SELECT
    indexname,
    indexdef
FROM pg_indexes
WHERE tablename IN (
    'products',
    'orders',
    'employees'
)
ORDER BY tablename, indexname;


