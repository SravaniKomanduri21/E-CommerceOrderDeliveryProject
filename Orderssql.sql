SELECT * FROM orders;
SELECT COUNT(*) FROM orders;#Total numbers of orders
SELECT SUM(order_amount) FROM orders;#Total revenue
SELECT COUNT(DISTINCT customer_id)
FROM orders;#Unique customers
SELECT order_status,COUNT(*)
FROM orders
GROUP BY order_status; #Orders by Status
SELECT delivery_status,COUNT(*)
FROM orders
GROUP BY delivery_status;#Delivery status count
SELECT category,COUNT(*)
FROM orders
GROUP BY category;#Orders per category
SELECT category,SUM(order_amount)
FROM orders
GROUP BY category;#Total revenue by category
SELECT AVG(order_amount)FROM orders;#Average order value
SELECT city,COUNT(*)
FROM orders
GROUP BY city;#Orders per city
SELECT MAX(order_amount)FROM orders;#Max order amount
SELECT MIN(order_amount)FROM orders;#Min order amount
SELECT payment_method,COUNT(*)
FROM orders
GROUP BY payment_method;#Orders per payment mode
SELECT SUM(quantity)FROM orders;#Total quantity sold
SELECT DISTINCT category FROM orders;#Distinct Categories
SELECT AVG(DATEDIFF(delivery_rate,ship_date)) AS avg_delivery_days
FROM orders;#Average delivery time
SELECT category,
AVG(DATEDIFF(delivery_date,ship_date))
FROM orders
GROUP BY category;#Delivery time per category
SELECT city,
AVG(DATEDIFF(delivery_date,ship_date))
FROM orders
GROUP BY city;#delivery time per city
SELECT YEAR(order_date) AS year,
MONTH(order_date) AS month,COUNT(*)
FROM orders
GROUP BY YEAR(order_date),
MONTH(order_date);#Monthly orders
SELECT YEAR(order_date),
MONTH(order_date),SUM(order_amount)
FROM orders
GROUP BY YEAR(order_date),
MONTH(order_date);#Monthly revenue
SELECT city,COUNT(*)
FROM orders
GROUP BY city
ORDER BY COUNT(*) DESC
LIMIT 5;#Top 5 cities by orders
SELECT COUNT(*)
FROM orders
WHERE DATEDIFF(delivery_date,ship_date)>7;#Orders with delivery >7 days
SELECT COUNT(*)
FROM orders
WHERE DATEDIFF(delivery_date,ship_date)<=5;#On-time deliveries(<=5) days
SELECT COUNT(*)
FROM orders
WHERE DATEDIFF(delivery_date,ship_date)>5;#Delayed deliveries(>5) days
SELECT SUM(order_amount)
FROM orders
WHERE DATEDIFF(delivery_date,ship_date)>5; #revenue from delayed orders
SELECT AVG(shipping_cost)FROM orders;#Average shipping cost
SELECT payment_method,
SUM(order_amount)
FROM orders
GROUP BY payment_method;#Revenue by payment method
SELECT state,COUNT(*)
FROM orders
GROUP BY state; #Order per state
SELECT AVG(quantity) FROM orders;#Avg quantity per order
SELECT city, MAX(order_amount)
FROM orders
GROUP BY city;#Highest order per city
SELECT MIN(DATEDIFF(delivery_date,ship_date)) FROM orders;#Lowest delivery time
SELECT MAX(DATEDIFF(delivery_date,ship_date)) FROM orders;#Highest delivery time
SELECT order_date, COUNT(*)
FROM orders
GROUP BY order_date; #Order per day
SELECT order_date,SUM(order_amount)
FROM orders
GROUP BY order_date;#Revenue per day
SELECT(COUNT(CASE WHEN DATEDIFF(delivery_date,ship_date)<=5 THEN 1 END)*100.0)
/COUNT(*) AS sla_percentage
FROM orders; #SLA %(on-time delivery)
SELECT 
  CASE 
    WHEN DATEDIFF(delivery_date, ship_date) <= 3 THEN 'Fast'
    WHEN DATEDIFF(delivery_date, ship_date) <= 5 THEN 'Normal'
    WHEN DATEDIFF(delivery_date, ship_date) <= 7 THEN 'Slow'
    ELSE 'Very Slow'
  END AS delivery_bucket,
  COUNT(*) 
FROM orders
GROUP BY delivery_bucket;# Delay bucket classification
SELECT city,
       AVG(DATEDIFF(delivery_date, ship_date)) AS avg_days,
       RANK() OVER (ORDER BY AVG(DATEDIFF(delivery_date, ship_date))) AS rank_city
FROM orders
GROUP BY city;#Rank cities by delivery time
SELECT * 
FROM orders
ORDER BY DATEDIFF(delivery_date, ship_date) DESC
LIMIT 3;#Top 3 delayed orders
SELECT category, AVG(DATEDIFF(delivery_date, ship_date)) AS avg_delay
FROM orders
GROUP BY category
ORDER BY avg_delay DESC
LIMIT 1;#Category with highest delay
SELECT city, AVG(DATEDIFF(delivery_date, ship_date)) AS avg_days
FROM orders
GROUP BY city
ORDER BY avg_days ASC
LIMIT 1;#City with best delivery performance
SELECT order_date,
       SUM(order_amount) OVER (ORDER BY order_date) AS running_total
FROM orders;#Running total revenue
SELECT category,
       SUM(order_amount) * 100.0 / (SELECT SUM(order_amount) FROM orders) AS percentage
FROM orders
GROUP BY category;#Revenue contribution %
SELECT customer_id, SUM(order_amount) AS total_spend
FROM orders
GROUP BY customer_id
ORDER BY total_spend DESC
LIMIT 5;#Top 5 customers by spend
SELECT customer_id, COUNT(*) 
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > 1;#Repeat customers (more than 1 order)
SELECT payment_method, AVG(DATEDIFF(delivery_date, ship_date))
FROM orders
GROUP BY payment_method;#Avg delivery by payment method
SELECT YEAR(order_date), MONTH(order_date),
       SUM(order_amount),
       LAG(SUM(order_amount)) OVER (ORDER BY YEAR(order_date), MONTH(order_date)) AS prev_month
FROM orders
GROUP BY YEAR(order_date), MONTH(order_date);#Monthly growth in revenue
SELECT * 
FROM orders
ORDER BY shipping_cost DESC
LIMIT 5;#Orders with highest shipping cost
SELECT *
FROM orders
WHERE order_amount > 4000 AND DATEDIFF(delivery_date, ship_date) > 5;#Correlation hint (high value orders)
SELECT 
  COUNT(*) AS total_orders,
  SUM(order_amount) AS total_revenue,
  AVG(DATEDIFF(delivery_date, ship_date)) AS avg_delivery_days
FROM orders;#Full performance summary


