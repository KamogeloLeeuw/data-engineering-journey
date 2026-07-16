-- =============================================
-- Retail Shop Database — Sample Data

-- Run schema.sql first before running this file
-- =============================================

-- Categories
INSERT INTO categories (category_name, description) VALUES
('Electronics', 'Phones, laptops, and accessories'),
('Clothing', 'Men and women apparel'),
('Food & Beverage', 'Groceries and drinks'),
('Stationery', 'Office and school supplies'),
('Home & Living', 'Furniture and home accessories');

-- Products
INSERT INTO products (product_name, category_id, price, stock_quantity) VALUES
('Samsung Galaxy A15', 1, 4999.99, 30),
('HP Laptop 15', 1, 12999.99, 15),
('Wireless Earbuds', 1, 899.99, 50),
('Men T-Shirt', 2, 299.99, 100),
('Women Jeans', 2, 549.99, 80),
('Running Shoes', 2, 1299.99, 40),
('Rooibos Tea 50 Pack', 3, 89.99, 200),
('Nescafe Coffee 500g', 3, 129.99, 150),
('A4 Paper Ream', 4, 79.99, 300),
('Ballpoint Pens 10 Pack', 4, 39.99, 500),
('Office Chair', 5, 2499.99, 20),
('Desk Lamp', 5, 449.99, 60);

-- Customers
INSERT INTO customers (first_name, last_name, email, city, join_date) VALUES
('Thabo', 'Nkosi', 'thabo.nkosi@email.com', 'Johannesburg', '2023-01-15'),
('Naledi', 'Mokoena', 'naledi.m@email.com', 'Pretoria', '2023-03-22'),
('Pieter', 'van der Berg', 'pieter.vdb@email.com', 'Cape Town', '2023-05-10'),
('Zanele', 'Dlamini', 'zanele.d@email.com', 'Durban', '2023-07-01'),
('Sipho', 'Mahlangu', 'sipho.m@email.com', 'Johannesburg', '2023-09-14'),
('Emma', 'Johnson', 'emma.j@email.com', 'Cape Town', '2024-01-05'),
('Karabo', 'Sithole', 'karabo.s@email.com', 'Pretoria', '2024-02-20'),
('Riaan', 'Botha', 'riaan.b@email.com', 'Johannesburg', '2024-04-11'),
('Grace', 'Nkosi', 'grace.n@email.com', 'Durban', '2024-06-30'),
('Lebo', 'Tau', 'lebo.t@email.com', 'Johannesburg', '2024-08-15');

-- Employees
INSERT INTO employees (first_name, last_name, position, salary) VALUES
('Kamogelo', 'Leeuw', 'Sales Associate', 15000),
('Thandeka', 'Moyo', 'Store Manager', 35000),
('David', 'Smith', 'Cashier', 12000),
('Priya', 'Naidoo', 'Sales Associate', 15000),
('Johan', 'Pretorius', 'Assistant Manager', 28000);

-- Orders
INSERT INTO orders (customer_id, employee_id, order_date, status) VALUES
(1, 1, '2024-01-10', 'Completed'),
(2, 2, '2024-01-15', 'Completed'),
(3, 1, '2024-02-03', 'Completed'),
(4, 3, '2024-02-20', 'Pending'),
(5, 4, '2024-03-05', 'Completed'),
(6, 2, '2024-03-18', 'Completed'),
(7, 5, '2024-04-01', 'Cancelled'),
(8, 1, '2024-04-22', 'Completed'),
(9, 3, '2024-05-10', 'Pending'),
(10, 4, '2024-05-28', 'Completed'),
(1, 2, '2024-06-14', 'Completed'),
(3, 5, '2024-07-09', 'Completed');

-- Order Items
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 4999.99),
(1, 3, 2, 899.99),
(2, 5, 1, 549.99),
(2, 4, 2, 299.99),
(3, 2, 1, 12999.99),
(4, 7, 3, 89.99),
(4, 8, 2, 129.99),
(5, 11, 1, 2499.99),
(6, 9, 5, 79.99),
(6, 10, 10, 39.99),
(7, 6, 1, 1299.99),
(8, 12, 2, 449.99),
(9, 1, 1, 4999.99),
(10, 3, 1, 899.99),
(11, 8, 3, 129.99),
(12, 4, 4, 299.99);
