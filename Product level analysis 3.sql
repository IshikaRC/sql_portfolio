CREATE DATABASE Ecommerce;
USE Ecommerce;
select * from Ecommerce limit 10;

/* PRODUCT LEVEL ANALYSIS

Sales per product */
select product_id, sum(quantity * unit_price) as Sales
from Ecommerce
group by product_id
order by sales DESC;

-- Daily average revenue
select order_date, avg(quantity * unit_price) as average_sales
from Ecommerce
group by order_date;

-- Averge sale
select avg(sales)
from (
select order_date, sum(quantity * unit_price) as sales
from Ecommerce
group by order_date
) t;

-- Most bought product
select product_id, product_name, category, sum(quantity) as Total_orders
from ecommerce
group by product_id, product_name, category
order by Total_orders DESC;

-- Highest revenue product
select product_id, product_name, sum(quantity*unit_price) as Revenue
from ecommerce
group by product_id, product_name
order by Revenue DESC;

-- Rank products basis total spending
select p.product_id, p.product_name, sum(o.quantity*p.unit_price) as Sales,
Rank() over(
order by sum(quantity*unit_price) DESC) as Product_Rank
FROM products p
join orders o
on p.order_id = o.order_id
group by p.product_id, p.product_name;

-- Comparison of year sales of products
select product_name, order_date, sum(quantity*unit_price) as Sales,
LAG(sum(quantity*unit_price)) over( partition by product_name order by order_date) as prev_yr_sales
from ecommerce
group by product_name, order_date;