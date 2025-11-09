create database pizzahut;

create table orders (
order_id int not null,
order_date date not null,
order_time time not null,
primary key(order_id)
);

create table order_details (
order_details_id int not null,
order_id int not null,
pizza_id text not null,
quantity int not null,
primary key(order_details_id)
);

-- 1. Retrieve the total number of orders placed.

SELECT 
    COUNT(order_id)
FROM
    orders;

-- 2. Calculate the total revenue generated from pizza sales.

SELECT 
    ROUND(SUM(od.quantity * p.price), 2)
FROM
    order_details AS od
        LEFT JOIN
    pizzas AS p ON od.pizza_id = p.pizza_id;

-- 3. Identify the highest-priced pizza.

SELECT 
    pt.name
FROM
    pizzas AS p
        JOIN
    pizza_types AS pt ON p.pizza_type_id = pt.pizza_type_id
ORDER BY p.price DESC
LIMIT 1;

-- 4. Identify the most common pizza size ordered.

SELECT 
    p.size, COUNT(p.size)
FROM
    order_details AS od
        LEFT JOIN
    pizzas AS p ON od.pizza_id = p.pizza_id
GROUP BY p.size
ORDER BY COUNT(p.size) DESC
LIMIT 1;

-- 5. List the top 5 most ordered pizza types along with their quantities.

SELECT 
    pt.name, SUM(od.quantity)
FROM
    order_details AS od
        LEFT JOIN
    pizzas AS p ON od.pizza_id = p.pizza_id
        LEFT JOIN
    pizza_types AS pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY SUM(od.quantity) DESC
LIMIT 5;

-- 6. Join the necessary tables to find the total quantity of each pizza category ordered.

SELECT 
    pt.category, SUM(od.quantity)
FROM
    order_details AS od
        JOIN
    pizzas AS p ON od.pizza_id = p.pizza_id
        JOIN
    pizza_types AS pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category;

-- 7. Determine the distribution of orders by hour of the day.

SELECT 
    HOUR(order_time), COUNT(order_id)
FROM
    orders
GROUP BY HOUR(order_time)
ORDER BY HOUR(order_time) ASC;

-- 8. Join relevant tables to find the category-wise distribution of pizzas.

SELECT 
    category, COUNT(name)
FROM
    pizza_types
GROUP BY category;

-- 9. Group the orders by date and calculate the average number of pizzas ordered per day.

SELECT 
    ROUND(AVG(quantity))
FROM
    (SELECT 
        o.order_date AS date, SUM(od.quantity) AS quantity
    FROM
        orders AS o
    JOIN order_details AS od ON o.order_id = od.order_id
    GROUP BY o.order_date) AS new;

-- 10. Determine the top 3 most ordered pizza types based on revenue.


SELECT 
    pt.name, SUM(od.quantity * p.price)
FROM
    order_details AS od
        JOIN
    orders AS o ON od.order_id = o.order_id
        JOIN
    pizzas AS p ON od.pizza_id = p.pizza_id
        JOIN
    pizza_types AS pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY SUM(od.quantity * p.price) DESC
LIMIT 3;

-- 11. Calculate the percentage contribution of each pizza type to total revenue.


SELECT 
    pt.category,
    100 * SUM(od.quantity * p.price) / (SELECT 
            SUM(od.quantity * p.price)
        FROM
            order_details AS od
                JOIN
            pizzas AS p ON od.pizza_id = p.pizza_id
                JOIN
            pizza_types AS pt ON p.pizza_type_id = pt.pizza_type_id) AS new
FROM
    order_details AS od
        JOIN
    pizzas AS p ON od.pizza_id = p.pizza_id
        JOIN
    pizza_types AS pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category;

-- 12. Analyze the cumulative revenue generated over time.


select new_date, sum(rev) over (order by new_date)
from
(select o.order_date as new_date, sum(od.quantity*p.price) as rev from order_details as od
join orders as o on od.order_id = o.order_id
join pizzas as p on od.pizza_id = p.pizza_id
join pizza_types as pt on p.pizza_type_id = pt.pizza_type_id
group by o.order_date) as new ;



-- 13. Determine the top 3 most ordered pizza types based on revenue for each pizza category.

with a as (
select pt.category as category ,pt.name as name, sum(od.quantity*p.price) as rev from order_details as od
join orders as o on od.order_id = o.order_id
join pizzas as p on od.pizza_id = p.pizza_id
join pizza_types as pt on p.pizza_type_id = pt.pizza_type_id
group by pt.name, pt.category
order by sum(od.quantity*p.price) desc)

select * from
			(select category, name, rev,
			rank() over(partition by category order by rev desc) as rn
			from a) as new
where rn <= 3;


