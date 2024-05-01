
# Pizza Sales SQL Analysis Project

## Overview
This project is a comprehensive analysis of pizza sales data, guided by the tutorials from the WsCube Tech YouTube channel. The project involves a dataset with various tables related to pizza sales, which were originally in CSV format and have been converted into SQL files for detailed querying and analysis.

## Dataset
The dataset includes the following tables:
- **Pizza Details**: Contains information about different types of pizzas and their prices.
- **Ingredients**: Lists the ingredients used for each pizza.
- **Orders**: Records the timings and dates of pizza orders.

## SQL Queries
The analysis consists of 10 SQL queries that address specific questions about the data

## Questions Solved
[questions]()

## The solution Queries
#1) Retrieve the total number of orders placed<br>
** SELECT COUNT(order_id) AS total_orders 
FROM orders ;

#2) Calculate the total revenue generated from pizza sales<br>
** SELECT 
ROUND(SUM(order_details.quantity * pizzas.price),2) 
AS total_sales
FROM order_details
JOIN pizzas 
ON pizzas.pizza_id = order_details.pizza_id;

#3) Identify the highest-priced pizza.<br>
** SELECT pizza_types.name as highest_price_item,pizzas.price
from pizza_types
join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id 
order by pizzas.price desc limit 1;

#4) Identify the most common pizza size ordered<br>
** select pizzas.size,count(order_details_id) as counts 
from pizzas
join order_details on pizzas.pizza_id = order_details.pizza_id
group by pizzas.size 
order by count(order_details_id) desc limit 1;

#5) List the top 5 most ordered pizza types along with their quantities<br>
** select pizza_types.name,sum(order_details.quantity) as quantity
from pizzas
join pizza_types on pizzas.pizza_type_id = pizza_types.pizza_type_id
join order_details on pizzas.pizza_id = order_details.pizza_id
group by pizza_types.name
order by sum(order_details.quantity) desc limit 5;


#6) Join the necessary tables to find the total quantity of each pizza category ordered<br>
** select pizza_types.category,sum(order_details.quantity) as quantity
from pizzas
join pizza_types on pizzas.pizza_type_id = pizza_types.pizza_type_id
join order_details on pizzas.pizza_id = order_details.pizza_id
group by pizza_types.category
order by sum(order_details.quantity) desc;

#7) Determine the distribution of orders by hour of the day<br>
** SELECT
  hour(order_time) AS OrderHour,
  COUNT(order_id) AS TotalOrders
FROM orders
GROUP BY hour(order_time);

#8) Join relevant tables to find the category-wise distribution of pizzas<br>
** select category,count(name) from pizza_types
group by category;

#9) Group the orders by date and calculate the average number of pizzas ordered per day<br>
** select round(avg(quantity),2) from (select orders.order_date,sum(order_details.quantity) as quantity
from orders
join order_details on orders.order_id = order_details.order_id
group by orders.order_date) as order_quantity;

#10) Determine the top 3 most ordered pizza types based on revenue<br>
** select pizza_types.name,round(sum(order_details.quantity * pizzas.price),2) as revenue
from pizzas
join pizza_types on pizzas.pizza_type_id = pizza_types.pizza_type_id
join order_details on pizzas.pizza_id = order_details.pizza_id
group by pizza_types.name
order by revenue desc limit 3;



## Tools Used
- **MySQL** : for writing sql queries

## Acknowledgements
Special thanks to WsCube Tech for their excellent tutorials on SQL, which guided me through this project.
