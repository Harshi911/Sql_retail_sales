select * from retail_sales;

-- data Exploration 

-- 1. How many sale we have?
select count(*) as total_sale from retail_sales;

-- How many unique customers we have?
select count(DISTINCT(customer_id)) as total_sale from retail_sales;

-- data Analysis & Business key problems & Answers.

-- Q1. Write a sql query to retrive all columns for sales made on '2022-11-05'

select * from retail_sales
where sale_date = '2022-11-05';

-- *Q2. write a sql query to retrive all transactions where the category is 'clothing' and the quantity sold 
--      is more than 4 in the month of Nov-2022

select category,sum(quantiy) from retail_sales
where category = 'Clothing'
AND quantiy = 3
AND MONTH(sale_date) = 11
AND YEAR(sale_date) = 2022;

-- Q3. write a sql query to calculate the total sales (total_sale) for each category.

select category,
sum(total_sale) as net_sale, 
count(*) as total_orders 
from retail_sales
group by 1;

-- Q4. write a sql query to find the average age of customers purchased items from the'Beauty' category.alter

select Round(Avg(age)) from retail_sales
where category = 'beauty';

-- Q5. write a sql query to find all transactions where the total_sale is greater than 1000.

select * from retail_sales
where total_sale > '1000';

-- Q6. write a sql query to find the total number of transactions (transaction_id) made by each gender in each category.

select category,gender,count(*) as total_trans from retail_sales
group by category, gender
order by 1;

-- imp Q7. write a sql query to calculate the average sale for each month.find out the best selling month in each year.

select 
      year,
      month,
      avg_sale
      from
(
select 
year(sale_date) as year,
month(sale_date) as month,
round(avg(total_sale)) as avg_sale,
rank() over(partition by year(sale_date) order by avg(total_sale) desc) as sales
from retail_sales
group by 1,2
) as t1
where sales =1;

-- Q8. write sql query to find the top 5 customers based on the highest total sales

select 
     customer_id,
     sum(total_sale) as total_sales
     from retail_sales
     group by 1
     order by 2 desc
     limit 5;
     
-- Q9. write a sql query to find the number of unique customers who purchased items from each category.

select 
count(distinct(customer_id)) as customer_id,
category 
from retail_sales
group by category;

-- Q10. write a sql query to create each shift and number of orders (example morning <=12, 
--         afternoon between 12 & 17 and evening >17

with hourly_sale
as
(
select *,
case
when hour(sale_time) <12 then 'morning'
when hour(sale_time) between 12 and 17 then 'afternoon'
else 'evening'
end as shift
from retail_sales
)
select
 shift,
 count(*) as total_orders from hourly_sale
group by shift;

-- END OF PROJECT