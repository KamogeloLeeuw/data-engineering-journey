-- =============================================
-- Retail Shop Database — Indexes
-- =============================================


-- Speed up product lookups by category
CREATE INDEX idx_products_category 
ON products(category_id);


-- Speed up order lookups by customer
CREATE INDEX idx_orders_customer 
ON orders(customer_id);


-- Speed up order lookups by employee
CREATE INDEX idx_orders_employee 
ON orders(employee_id);


-- Speed up order item lookups by order
CREATE INDEX idx_order_items_order 
ON order_items(order_id);


-- Speed up order item lookups by product
CREATE INDEX idx_order_items_product 
ON order_items(product_id);


-- Speed up customer lookups by city
CREATE INDEX idx_customers_city 
ON customers(city);

