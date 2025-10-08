--SQL retail sale analysis
create table retail_sales
(
transactions_id int primary key,
sale_date date,
sale_time time,
customer_id int,
gender varchar(10),
age int,
category varchar(10),
quantity int,
price_per_unit float,
cogs float,
total_sale float
)


select * from retail_sales
limit  10;
--Data cleaning

select * from retail_sales
limit 10
select * from retail_sales 
         where transactions_id is null
         or 
		 sale_date is null
		 or 
		 sale_time is null
		 or 
		 customer_id is null
		 or 
		 gender is null
		 or 
		 category is null
		 or 
		 quantity is null
		 or 
		 cogs is null
		 or 
		 total_sale is null


delete from retail_sales
       where 
	     transactions_id is null
         or 
		 sale_date is null
		 or 
		 sale_time is null
		 or 
		 customer_id is null
		 or 
		 gender is null
		 or 
		 category is null
		 or 
		 quantity is null
		 or 
		 cogs is null
		 or 
		 total_sale is null
select count (*)from retail_sales

--Data exploration

-- what is the Number of sales
 select count (*) as total_sales from retail_sales

--Number of customers 
select count (distinct customer_id) as total_customers from retail_sales

--Number of categories and their name
select count (distinct category) from retail_sales

select count (distinct category) from retail_sales

select distinct category from retail_sales

--Data analysis and Business Key Problems--

Q1. Write a query to retrieve all columns for sale made on '2022-11-05'

 select * from retail_sales where sale_date = '2022-11-05'

q2. Write a query to retrieve all transactions where category is clothing and the quantity sold
    is more than or equal to 4 in the month of Nov-2022

	select * from retail_sales 
	where category = 'Clothing' and quantity >= 4 
	and to_char (sale_date, 'YYYY-MM') = '2022-11'

q3. Write a query to calculate total sale for each category

	select category, sum (total_sale) as overall_sale,
	count (*) as total_order from retail_sales 
	        group by category

q4. Write a query to find the average age of customers who purchased items from the 'Beauty' category

    select round(avg (age),2) as average_age from retail_sales where category = 'Beauty'

q5. Write a sql query to find all the transactions where total_sales is greater than 1000.

    select * from retail_sales where total_sale > 1000

q6. Write a sql query to find total number of transactions (transactions_id) made by each gender in each category

    select category, gender, count (*) as total_trans from retail_sales group by category, gender order by category 


q7. write a query to calculate average sale each month. find out best selling month in each year.

  (A)  select year, month, avg_sale
	    from  (
		select
		extract (year from sale_date) as year,
		  extract (month from sale_date) as month,
		  avg (total_sale) as avg_sale,
		  Rank() over(partition by extract (year from sale_date) order by avg(total_sale) desc) as rank
		  from retail_sales
          group by 1,2 
		  ) as t1
		  where rank = 1

	(B)	  SELECT DISTINCT ON (year)
    EXTRACT(YEAR FROM sale_date) AS year,
    EXTRACT(MONTH FROM sale_date) AS month,
    AVG(total_sale) AS avg_sale
FROM retail_sales
GROUP BY 1, 2
ORDER BY 1, 3 DESC
     
q8. write a query to find the top 5 customers based on highest total sales
    
    select * from retail_sales
    select 
	      customer_id,
		  sum(total_sale)
		  from retail_sales 
		  group by customer_id
          order by sum desc limit 5
		  
q9. write a query to find the number of unique customers who purchased order from each category

    select * from retail_sales
	
    select
	count (distinct customer_id) as unq_cus,
	category from retail_sales
	group by category
