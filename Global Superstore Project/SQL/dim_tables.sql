CREATE TABLE dim_order AS
SELECT
    order_id,
	order_date,
    ship_date,
    ship_mode,
    order_priority
FROM fact_sales;
select * from dim_order;



CREATE TABLE dim_customer AS
SELECT
    customer_id,
    customer_name,
    segment,
    city,
    state,
    country,
    market,
    region
FROM fact_sales;
select * from dim_customer;


CREATE TABLE dim_product as
select 
	product_id,
    category,
    sub_category,
    product_name
    
FROM fact_sales;
select * from dim_product;


#dropping from fact table
alter table fact_sales
drop column  order_date,
drop  column  ship_date,
drop column ship_mode,
drop column order_priority,
drop column customer_name,
drop column segment,
drop column city,
drop column state,
drop column country,
drop column market,
drop column region,
drop column category,
drop column sub_category,
drop column product_name;