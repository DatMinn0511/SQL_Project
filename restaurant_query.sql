SELECT * FROM menu_items;
SELECT * FROM order_details;



--1. Combune the menu_items and order_details tabbles into a single table.
SELECT * FROM order_details AS o LEFT JOIN menu_items AS m 
ON m.menu_item_id = o.item_id;


--2. What were the least and most ordered items? What categories were they in?
SELECT item_name, category, COUNT(order_id) AS num_purchases FROM order_details AS o LEFT JOIN menu_items AS m 
ON m.menu_item_id = o.item_id
GROUP BY item_name, category
ORDER BY num_purchases DESC;


--3. What were the top 5 orders that spent the most money?
SELECT TOP 5 order_id, SUM(price) AS total_spent FROM order_details AS o LEFT JOIN menu_items AS m 
ON m.menu_item_id = o.item_id
GROUP BY order_id
ORDER BY total_spent DESC
;


--4. View the details of the top 5 highest spending orders and find what cuisine they almost like.

WITH top5_highest_spent AS (

SELECT TOP 5 order_id, SUM(price) AS total_spent FROM order_details AS o LEFT JOIN menu_items AS m 
ON m.menu_item_id = o.item_id
GROUP BY order_id
ORDER BY total_spent DESC

)
SELECT order_id, category, COUNT(order_id) AS num_items FROM order_details AS o LEFT JOIN menu_items AS m 
ON m.menu_item_id = o.item_id WHERE order_id IN (SELECT order_id FROM top5_highest_spent)
GROUP BY order_id, category
ORDER BY order_id;
