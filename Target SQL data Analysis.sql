#1.Import the dataset and do usual exploratory analysis steps like checking the structure & characteristics of the dataset: 
#   1. Data type of all columns in the "customers" table. 
#   2. Get the time range between which the orders were placed.
select * from `target.customers` limit 10;


#   2. Get the time range between which the orders were placed.
select min(order_purchase_timestamp) as start_time, max(order_purchase_timestamp) as end_time from `target.orders`;


#   3. Count the Cities & States of customers who ordered during the given period.
SELECT
    COUNT(DISTINCT T1.customer_city) AS total_unique_cities,
    COUNT(DISTINCT T1.customer_state) AS total_unique_states
FROM
    `target.customers` AS T1
INNER JOIN
    `target.orders` AS T2
    ON T1.customer_id = T2.customer_id;
    
    
#   4.Is there a growing trend in the no. of orders placed over the past years?
SELECT
    EXTRACT(MONTH FROM order_purchase_timestamp) as order_year_month,
    COUNT(order_id) AS number_of_orders
FROM
    `target.orders`
GROUP BY
    order_year_month 
ORDER BY
    number_of_orders desc;


# 5. During what time of the day, do the Brazilian customers mostly place their orders?
SELECT
    CASE
        WHEN EXTRACT(HOUR FROM order_purchase_timestamp) BETWEEN 0 AND 6 THEN 'Dawn (0-6 hrs)'
        WHEN EXTRACT(HOUR FROM order_purchase_timestamp) BETWEEN 7 AND 12 THEN 'Morning (7-12 hrs)'
        WHEN EXTRACT(HOUR FROM order_purchase_timestamp) BETWEEN 13 AND 18 THEN 'Afternoon (13-18 hrs)'
        ELSE 'Night (19-23 hrs)'
    END AS time_of_day,
    COUNT(order_id) AS number_of_orders
FROM
    `target.orders`
GROUP BY
    time_of_day
ORDER BY
    number_of_orders DESC;
    
    
#   6. Get the month on month no. of orders placed in each state.

SELECT
    T2.customer_state,
    FORMAT_DATE('%Y-%m', DATE(T1.order_purchase_timestamp)) AS order_year_month,
    COUNT(T1.order_id) AS number_of_orders
FROM
    `target.orders` AS T1
INNER JOIN
    `target.customers` AS T2
    ON T1.customer_id = T2.customer_id
GROUP BY
    T2.customer_state,
    order_year_month
ORDER BY
    T2.customer_state,
    order_year_month;
    
    
#   7. How are the customers distributed across all the states?
SELECT
    customer_state,
    COUNT(DISTINCT customer_unique_id) AS number_of_unique_customers
FROM
    `target.customers`
GROUP BY
    customer_state
ORDER BY
    number_of_unique_customers DESC;
    
    
# 8. Get the % increase in the cost of orders from year 2017 to 2018 (include months between Jan to Aug only).

WITH YearlyPayment AS (
    SELECT
        EXTRACT(YEAR FROM T2.order_purchase_timestamp) AS order_year,
        EXTRACT(MONTH FROM T2.order_purchase_timestamp) AS order_month,
        T1.payment_value
    FROM
        `target.payments` AS T1
    INNER JOIN
        `target.orders` AS T2
        ON T1.order_id = T2.order_id
),
AggregatedPayments AS (
    SELECT
        order_year,
        SUM(payment_value) AS total_payment_value
    FROM
        YearlyPayment
    WHERE
        order_year IN (2017, 2018) AND order_month BETWEEN 1 AND 8
    GROUP BY
        order_year
)
SELECT
    T2018.total_payment_value AS total_payment_2018,
    T2017.total_payment_value AS total_payment_2017,
    -- Calculate percentage increase: ((Total_2018 - Total_2017) / Total_2017) * 100
    ((T2018.total_payment_value - T2017.total_payment_value) * 100.0 / T2017.total_payment_value) AS percentage_increase
FROM
    AggregatedPayments AS T2018
JOIN
    AggregatedPayments AS T2017
    ON 1=1
WHERE
    T2018.order_year = 2018 AND T2017.order_year = 2017;
    

#   9. Calculate the Total & Average value of order price for each state.

SELECT
    T3.customer_state,
    SUM(T1.price) AS total_order_price,
    AVG(T1.price) AS average_order_price
FROM
    `target.order_items` AS T1
INNER JOIN
    `target.orders` AS T2
    ON T1.order_id = T2.order_id
INNER JOIN
    `target.customers` AS T3
    ON T2.customer_id = T3.customer_id
GROUP BY
    T3.customer_state
ORDER BY
    total_order_price DESC;
    
    
# 10. Calculate the Total & Average value of order freight for each state.

SELECT
    T3.customer_state,
    SUM(T1.freight_value) AS total_order_freight,
    AVG(T1.freight_value) AS average_order_freight
FROM
    `target.order_items` AS T1
INNER JOIN
    `target.orders` AS T2
    ON T1.order_id = T2.order_id
INNER JOIN
    `target.customers` AS T3
    ON T2.customer_id = T3.customer_id
GROUP BY
    T3.customer_state
ORDER BY
    total_order_freight DESC;
    
    
#   11. Find the no. of days taken to deliver each order and the difference between estimated & actual delivery date.

SELECT
    order_id,
    DATE_DIFF(DATE(order_delivered_customer_date), DATE(order_purchase_timestamp), DAY) AS time_to_deliver_days,
    DATE_DIFF(DATE(order_estimated_delivery_date), DATE(order_delivered_customer_date), DAY) AS diff_estimated_delivery_days
FROM
    `target.orders`
WHERE
    order_delivered_customer_date IS NOT NULL
    AND order_purchase_timestamp IS NOT NULL
    AND order_estimated_delivery_date IS NOT NULL;
    
    
#   12. Find out the top 5 states with the highest & lowest average freight value.
WITH StateFreight AS (
    SELECT
        T3.customer_state,
        AVG(T1.freight_value) AS average_freight_value
    FROM
        `target.order_items` AS T1
    INNER JOIN
        `target.orders` AS T2
        ON T1.order_id = T2.order_id
    INNER JOIN
        `target.customers` AS T3
        ON T2.customer_id = T3.customer_id
    GROUP BY
        T3.customer_state
)
( 
  SELECT
      customer_state,
      average_freight_value,
      'Highest' as Rank_Type
  FROM
      StateFreight
  ORDER BY
      average_freight_value DESC
  LIMIT 5
)
UNION ALL
( 
  SELECT
      customer_state,
      average_freight_value,
      'Lowest' as Rank_Type
  FROM
      StateFreight
  ORDER BY
      average_freight_value ASC
  LIMIT 5
);


#   13. Find out the top 5 states with the highest & lowest average delivery time.

WITH StateDeliveryTime AS (
    SELECT
        T2.customer_state,
        AVG(DATE_DIFF(DATE(T1.order_delivered_customer_date), DATE(T1.order_purchase_timestamp), DAY)) AS average_delivery_time_days
    FROM
        `target.orders` AS T1
    INNER JOIN
        `target.customers` AS T2
        ON T1.customer_id = T2.customer_id
    WHERE
        T1.order_delivered_customer_date IS NOT NULL
    GROUP BY
        T2.customer_state
)
(
  SELECT
      customer_state,
      average_delivery_time_days,
      'Highest' as Rank_Type
  FROM
      StateDeliveryTime
  ORDER BY
      average_delivery_time_days DESC
  LIMIT 5
)
UNION ALL
(
  SELECT
      customer_state,
      average_delivery_time_days,
      'Lowest' as Rank_Type
  FROM
      StateDeliveryTime
  ORDER BY
      average_delivery_time_days ASC
  LIMIT 5
);


#   14. Find out the top 5 states where the order delivery is really fast as compared to the estimated date of delivery.

SELECT
    T2.customer_state,
    AVG(DATE_DIFF(DATE(T1.order_estimated_delivery_date), DATE(T1.order_delivered_customer_date), DAY)) AS avg_delivery_speed_vs_estimate_days
FROM
    `target.orders` AS T1
INNER JOIN
    `target.customers` AS T2
    ON T1.customer_id = T2.customer_id
WHERE
    T1.order_delivered_customer_date IS NOT NULL
    AND T1.order_estimated_delivery_date IS NOT NULL
GROUP BY
    T2.customer_state
ORDER BY
    avg_delivery_speed_vs_estimate_days DESC -- Highest positive difference means fastest delivery vs estimate
LIMIT 5;


#   15. Find the month on month no. of orders placed using different payment types.

SELECT
    FORMAT_DATE('%Y-%m', DATE(T2.order_purchase_timestamp)) AS order_year_month,
    T1.payment_type,
    COUNT(DISTINCT T1.order_id) AS number_of_orders
FROM
    `target.payments` AS T1
INNER JOIN
    `target.orders` AS T2
    ON T1.order_id = T2.order_id
GROUP BY
    order_year_month,
    T1.payment_type
ORDER BY
    order_year_month,
    number_of_orders DESC;
    
    
#   16. Find the no. of orders placed on the basis of the payment installments that have been paid.

SELECT
    payment_installments,
    COUNT(DISTINCT order_id) AS number_of_orders
FROM
    `target.payments`
GROUP BY
    payment_installments
ORDER BY
    payment_installments ASC;