CREATE TABLE fact_sales AS
SELECT
    row_id,
    order_id,
    STR_TO_DATE(order_date,'%d-%m-%Y') AS order_date,
    STR_TO_DATE(ship_date,'%d-%m-%Y') AS ship_date,
    ship_mode,
    customer_id,
    customer_name,
    segment,
    city,
    state,
    country,
    market,
    region,
    product_id,
    category,
    sub_category,
    product_name,
    sales,
    quantity,
    discount,
    profit,
    shipping_cost,
    order_priority
FROM global_superstore;

select * from fact_sales;

select YEAR(order_date) as years,round(sum(sales),2) as total_sales from fact_sales
group by years order by total_sales;

select month(Order_date) as month,round(sum(sales),2) as total_sales from fact_sales
group by month order by month;

select YEAR(order_date) as years,round(sum(sales),2) as total_sales from fact_sales
group by years order by total_sales desc;

describe fact_sales;

# analysis process

#Top 10 product by sales

select 
product_name,
round(sum(sales),2) as Total_sales
from fact_sales
group by product_name
order by Total_sales desc
limit 10;

#Top 5 customer by profit

select customer_name,
round(sum(profit),2) as Total_profit
from fact_sales
group by customer_name
order by Total_profit desc
limit 5;

# Total sales by country
select country,
round(sum(sales),2) as total_sales from fact_sales
group by country
order by total_sales desc;

#monthly sales trend
select
year(order_date) as Year,
month(order_date) as month,
round(sum(sales),2) as montly_sales
from fact_Sales
group by year(order_date),month(order_date)
order by year,month;

#categorywise profit
select category,
round(sum(profit),2) as Total_profit
from fact_sales
group by category
order by Total_profit;

#regionwise sales
select region,
round(sum(sales),2) as Total_sales
from fact_Sales
group by region 
order by Total_sales desc;

#Top loss making Product
select product_name,
round(sum(profit),2) as Total_loss
from fact_Sales
group by product_name
having Total_loss<0
order by Total_loss asc
limit 10;

#negative profit orders
select * from fact_sales where profit<0;

# Total Sales and Total profit by category
select category,
round(sum(sales),2) as Total_sale,
round(sum(sales),2) as Total_profit
from fact_sales
group by category
order by Total_sale desc;

#Top 5 countries by profit
select country,
round(sum(profit),2) as Total_profit
from fact_sales
group by country
order by Total_profit desc
limit 5;

#most 10 profitable product
select product_name,
round(sum(profit),2) as Total_profit
from fact_sales
group by product_name
order by Total_profit desc
limit 10;

# fastest shiping mode
select ship_mode,
round(avg(datediff(ship_date,order_date)),2) as Avg_delivery_date
from fact_sales
group by ship_mode
order by Avg_delivery_date asc;

#shipping performance by ship mode
select ship_mode,
round(avg(datediff(ship_date,order_date)),2) as Avg_delivery_date
from fact_sales
group by ship_mode
order by Avg_delivery_date;

#average shipping days by region
select region,
round(avg(datediff(ship_date,order_date)),2) as Avg_delivery_date
from fact_sales
group by region
order by Avg_delivery_date desc;

#count order taking more than 7 days
select
count(*) as Delayed_Order 
from fact_sales
where datediff(ship_date,order_date)>7;

#discount imapct on profit
select
round(discount*100,2) as discount_percentage,
round(avg(profit),2) as avg_profit
from fact_sales
group by discount
order by discount;

#Repeat customer ranking
select 
   customer_name,
   count(distinct order_id) as total_orders,
   rank() over(order by count(distinct order_id) desc) as customer_rank
   from fact_sales
   group by customer_name;
   
   
#Top Product in each Category

with product_rank as
(select 
product_name,
category,
sum(sales) as Total_sales,
row_number() over(partition by category order by sum(sales) desc) as rn
from fact_sales 
group by category,product_name)
select * from product_rank
WHERE rn = 1;

#Monthly growth

WITH monthly_sales as
(
select
month(order_date) as months,
sum(sales) as total_sales
from fact_sales
group by months
)select
months,
total_sales,
total_Sales - lag(total_sales) over (order by months) as growth,
lag(Total_sales) over (order by months) as previous_month
from monthly_Sales;



#Region sales percentage
select region,
sum(sales) as Total_Sales,
round(sum(sales)*100/sum(sum(sales)) over(),2) as sales_percentage
from fact_sales
group by region;
#Running sales total
with monthly_sales as
(
select month(order_date) as month,
sum(sales) as Total_sales
from fact_sales
group by month)
select 
month,
total_sales,
sum(total_Sales) over (order by month) as running_total
from monthly_sales;
# Top 10 customer by profit
WITH customer_profit as 
(
select customer_name,
sum(profit) as total_profit,
dense_rank() over(order by sum(profit) desc) as rank_no
from fact_Sales
group by customer_name)
select * from customer_profit
where rank_no<=10;
#Final KPI query
select
round(sum(sales),2) as Total_Sales,
round(sum(profit),2) as Total_profit,
count(distinct order_id) as Total_order,
count(distinct customer_id) as Total_customer,
round(avg(discount)*100,2) as avg_discount
from fact_Sales;


   
  



















