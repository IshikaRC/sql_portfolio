create database ecommerce;
use ecommerce;

Select * from ecommerce limit 10;

-- count rows
select count(*) from ecommerce;

-- Count unique customers
select count(distinct customer_id) from ecommerce;

-- Check date range
select min(order_date), max(order_date) from ecommerce;

-- Check null values
select * from ecommerce where customer_id is null;

-- find distinct products
select count(distinct product_id) from ecommerce;

/* SALES ANALYSIS

Total revenue */
select sum(quantity * unit_price) as "Total Revenue" from ecommerce;

-- Average order values
select avg(quantity * unit_price) as "Average order value" from ecommerce;

-- Revenue per day
select order_date, sum(quantity*unit_price)
from ecommerce
group by order_date;

-- Revenue per month
select month(order_date), sum(quantity * unit_price)
from ecommerce
group by month(order_date);