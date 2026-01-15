{{
    config(
        materialized='table',
        tags=['marts', 'dimensions']
    )
}}

WITH customer_orders AS (
    SELECT * FROM {{ ref('int_customer_orders') }}
)

SELECT
    customer_id,
    first_name,
    last_name,
    email,
    first_name || ' ' || last_name AS full_name,
    total_orders,
    lifetime_value,
    CASE
        WHEN lifetime_value >= 1000 THEN 'High Value'
        WHEN lifetime_value >= 500 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment,
    first_order_date,
    last_order_date,
    DATEDIFF(day, first_order_date, last_order_date) AS days_as_customer
FROM customer_orders