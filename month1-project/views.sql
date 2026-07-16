-- =============================================
-- Retail Shop Database — Views
-- =============================================

-- View 1: Full order summary
CREATE VIEW order_summary AS
SELECT 
    o.order_id,
    c.first_name AS customer_first,
    c.last_name AS customer_last,
    c.city,
    e.first_name AS processed_by,
    o.order_date,
    o.status,
    SUM(oi.quantity * oi.unit_price) AS order_total
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
INNER JOIN employees e ON o.employee_id = e.employee_id
INNER JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY o.order_id, c.first_name, c.last_name, 
         c.city, e.first_name, o.order_date, o.status;


-- View 2: Product catalogue with category
CREATE VIEW product_catalogue AS
SELECT 
    p.product_id,
    p.product_name,
    c.category_name,
    p.price,
    p.stock_quantity,
    CASE
        WHEN p.price >= 5000 THEN 'Premium'
        WHEN p.price >= 1000 THEN 'Mid-Range'
        WHEN p.price >= 500 THEN 'Budget'
        ELSE 'Affordable'
    END AS price_category
FROM products p
INNER JOIN categories c ON p.category_id = c.category_id;


-- View 3: Employee sales performance
CREATE VIEW employee_performance AS
SELECT 
    e.employee_id,
    e.first_name,
    e.last_name,
    e.position,
    COUNT(o.order_id) AS orders_processed,
    SUM(oi.quantity * oi.unit_price) AS total_sales
FROM employees e
INNER JOIN orders o ON e.employee_id = o.employee_id
INNER JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY e.employee_id, e.first_name, e.last_name, e.position;


SELECT * FROM order_summary;
SELECT * FROM product_catalogue;
SELECT * FROM employee_performance;
