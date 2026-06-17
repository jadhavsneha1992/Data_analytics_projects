select * from global_superstore;
select * from global_superstore where Postal_COde is null;
select * from global_superstore where Row_Id IS NULL OR Order_ID is null OR Order_Date is null;
alter table global_superstore drop column Postal_Code;
show columns from global_superstore;
select distinct count(order_id) from global_superstore;
select distinct count(Customer_ID) from global_superstore;
select * from global_superstore;
set sql_safe_updates=0;
UPDATE global_superstore
SET Customer_Name = TRIM(Customer_Name);
set sql_safe_update=1;