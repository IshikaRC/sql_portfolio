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
select customer_id, sum(quantity*unit_price) as "Total Spent"
from ecommerce
group by customer_id
order by "Total_Spent" DESC
LIMIT 5;

-- Avergae spend per customer
select customer_id, avg(quantity*unit_price) as "Average Spend"
from ecommerce
group by customer_id
order by "Average Spend" DESC;

-- Repeat customers
select customer_id
from ecommerce
group by customer_id
having count(*)>5;

-- New vs repeat customers
select customer_id,
case
when count(*) = 1 then "New"
else "Repeat"
end as type
from Ecommerce
Group by customer_id

-- above average spending
select customer_id, sum(quantity * unit_price)
from Ecommerce
group by customer_id
having sum(quantity * unit_price) > (
select avg(sales)
from (
select customer_id, sum(quantity * unit_price) as "sales"
from Ecommerce
group by customer_id
) t
);