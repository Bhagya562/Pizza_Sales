SELECT TOP (1000) [pizza_id]
      ,[order_id]
      ,[pizza_name_id]
      ,[quantity]
      ,[order_date]
      ,[order_time]
      ,[unit_price]
      ,[total_price]
      ,[pizza_size]
      ,[pizza_category]
      ,[pizza_ingredients]
      ,[pizza_name]
  FROM [PizzaDB].[dbo].[pizza_sales]

  --Total Revenue:
  select sum(total_price) as total_revenue from [PizzaDB].[dbo].[pizza_sales]

  --Avg order value
  select sum(total_price)/count(distinct order_id) as Avg_OrderValue from [PizzaDB].[dbo].[pizza_sales]

  --Total pizza sold
  select sum(quantity) as total_PizzaSold from [PizzaDB].[dbo].[pizza_sales]

  --Total order placed
  select count(distinct order_id) as total_orders from [PizzaDB].[dbo].[pizza_sales]
 
 --Avg pizza sold per order
 select sum(quantity)/count(distinct order_id) as avg_pizzaSold_perOrder from [PizzaDB].[dbo].[pizza_sales]


 --Daily Trends for total orders
 select DATENAME(WEEKDAY,[order_date]) as Order_day ,count(distinct order_id) as total_orders from [PizzaDB].[dbo].[pizza_sales]
 group by DATENAME(WEEKDAY,[order_date])


 --Hourly Trends for Total orders
 select DATEPART(HOUR, order_time) as Order_hour, count(distinct order_id) as total_orders from [PizzaDB].[dbo].[pizza_sales] 
 group by DATEPART(HOUR, order_time)
 order by DATEPART(HOUR, order_time) asc

 --3---%of sales by Pizza category
 select pizza_category, CAST(sum(total_price)as decimal(10,3)) as total_revenue,
 CAST(sum(total_price)*100/(select sum(total_price) from [PizzaDB].[dbo].[pizza_sales])as decimal(10,2)) as PRCT
 from [PizzaDB].[dbo].[pizza_sales]
 group by pizza_category

 --4---%of sales by Pizza size
 select pizza_size, CAST(sum(total_price)as decimal(10,3)) as total_revenue,
 CAST(sum(total_price)*100/(select sum(total_price) from [PizzaDB].[dbo].[pizza_sales])as decimal(10,2)) as PRCT
 from [PizzaDB].[dbo].[pizza_sales]
 group by pizza_size

 --5--Total pizza sold by pizza category
 select pizza_category, sum(quantity)as total_sold from [PizzaDB].[dbo].[pizza_sales]
 group by pizza_category

 --6--Top 5 best salers by total pizza sold
 select top 5 pizza_name, sum(quantity) as total_sold from [PizzaDB].[dbo].[pizza_sales]
 group by pizza_name
 order by sum(quantity) desc

 --7--bottom 5 worst salers by total pizza sold
 select top 5 pizza_name, sum(quantity) as total_sold from [PizzaDB].[dbo].[pizza_sales]
 group by pizza_name
 order by sum(quantity) asc