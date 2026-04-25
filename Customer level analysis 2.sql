/* CUSTOMER LEVEL ANALYSIS */

-- Orders per customer
select customer_id, count(*)
from ecommerce
group by customer_id;

-- total spend per customer
select customer_id, sum(quantity*unit_price)
from ecommerce
group by customer_id;

-- Top 5 customers
select customer_id, sum(quantity*unit_price) as Total
from ecommerce
group by customer_id
order by Total DESC
LIMIT 5;

-- Avergae spend per customer
select customer_id, avg(quantity*unit_price) as Average_Spend
from ecommerce
group by customer_id
order by Average_Spend DESC;

-- Repeat customers
select customer_id
from ecommerce
group by customer_id
having count(*)>5;

-- New vs repeat customers
select customer_id,
case
when count(*) = 1 then 'New'
else 'Repeat'
end as type
from Ecommerce
Group by customer_id

-- Segmentation of customers
SELECT customer_id, SUM(quantity * unit_price) AS Total,
CASE 
WHEN SUM(quantity * unit_price) > 5000 THEN 'High Value'
WHEN SUM(quantity * unit_price) > 2000 THEN 'Medium Value'
ELSE 'Low Value'
END AS segment
FROM ecommerce
GROUP BY customer_id;

-- Select customer on the basis of expenditure
select customer_id, first_name, country,
sum(quantity * unit_price) as Total,
case
when sum(quantity * unit_price) > 5000 then 'High Value'
when sum(quantity * unit_price) > 3000 then 'Medium Value'
else 'Low Value'
end as customer_segment
from Ecommerce
group by customer_id, first_name, country;

-- above average spending
select customer_id, sum(quantity * unit_price)
from Ecommerce
group by customer_id
having sum(quantity * unit_price) > (
select avg(sales)
from (
select customer_id, sum(quantity * unit_price) as sales
from Ecommerce
group by customer_id
) t
);

-- Rank customers basis total spending
select c.customer_id, c.first_name, sum(o.quantity*o.unit_price) as Total_spent,
RANK() OVER ( 
ORDER BY sum(o.quantity*o.unit_price) DESC) AS cust_rank
FROM customers c
JOIN orders o
ON c.order_id = o.order_id
GROUP BY c.customer_id, c.first_name;

-- Rank customers within each country
Select c.customer_id, c.first_name, c.country, sum(o.quantity*o.unit_price) as Total_spent,
RANK() OVER ( PARTITION BY c.country
ORDER BY sum(o.quantity*o.unit_price) DESC) AS cust_rank
FROM customers c
JOIN orders o
ON c.order_id = o.order_id
GROUP BY c.customer_id, c.first_name, country;

-- Compare previous year revenue
select order_date, sum(quantity*unit_price) as revenue,
LAG(sum(quantity*unit_price)) OVER ( order by order_date) as prev_yr_rev
from Ecommerce
group by order_date;