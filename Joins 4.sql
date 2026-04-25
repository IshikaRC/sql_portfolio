-- Customers table
CREATE TABLE customers as
select customer_id, first_name, order_id, country
from Ecommerce;

-- Products table
create table products as
select product_id, product_name, unit_price, order_id
from Ecommerce;

-- Orders Table
CREATE TABLE orders AS
SELECT order_id, order_date, quantity, unit_price, product_id, customer_id
FROM Ecommerce;

Alter table orders
drop column product_id,
drop column customer_id;

SELECT * FROM orders LIMIT 5;
SELECT * FROM customers LIMIT 5;

SELECT COUNT(*) FROM orders;
SELECT COUNT(*) FROM customers;

SELECT DISTINCT order_id FROM orders;
SELECT DISTINCT customer_id FROM customers;

-- Join 2 tables with all the columns
SELECT *
FROM orders o
JOIN customers c
ON o.order_id = c.order_id;

-- Join customers and order table
SELECT o.order_id, c.first_name, o.order_date
FROM orders o
JOIN customers c
ON o.order_id = c.order_id
LIMIT 10;

-- Join customers and products table
select p.product_id, c.customer_id, product_name
from customers c
join products p
on p.order_id = c.order_id
limit 10;

-- Join customers, products and order table
select c.customer_id, first_name, product_name, quantity, o.unit_price
from products p
join customers c
on p.order_id = c.order_id
join orders o
on p.order_id = o.order_id
limit 10;

-- Customer total spending
SELECT c.customer_id, sum(o.quantity* o.unit_price) as Total_Spent, c.first_name, country
from orders o
join customers c
on o.order_id = c.order_id
group by c.customer_id, c.first_name, country;

-- Produc-wise Revenue
select p.product_name, sum(o.quantity * o.unit_price) as Total_Spent
from products p
join orders o
on p.order_id = o.order_id
group by p.product_name;

-- Top customers with product detail

-- Where customer order is null (Left join)
SELECT c.customer_id, c.first_name, o.order_id
FROM customers c
LEFT JOIN orders o
ON c.order_id = o.order_id
where o.order_id is NULL;

-- All orders even if customer details are missing
SELECT c.customer_id, c.first_name, o.order_id
FROM customers c
RIGHT JOIN orders o
ON c.order_id = o.order_id;

-- All orders even if customer details are missing to find null orders
SELECT c.customer_id, c.first_name, o.order_id
FROM customers c
RIGHT JOIN orders o
ON c.order_id = o.order_id
WHERE c.order_id IS NULL;

-- Find products never order
SELECT p.product_id, p.product_name, o.order_id
FROM products p
LEFT JOIN orders o
ON p.order_id = o.order_id
WHERE o.order_id IS NULL;

-- Product coverage
SELECT p.product_id, p.product_name, o.order_id
FROM products p
RIGHT JOIN orders o
ON p.order_id = o.order_id
WHERE p.order_id IS NULL;