{{
    config(
        materialized='table',
        tags=['marts', 'aggregates']
    )
}}

WITH sales AS (
    SELECT * FROM {{ ref('fct_sales') }}
)

SELECT
    order_date,
    product_category,
    COUNT(DISTINCT order_id) AS order_count,
    COUNT(DISTINCT customer_id) AS customer_count,
    SUM(quantity) AS total_quantity,
    SUM(line_total) AS total_revenue,
    AVG(line_total) AS avg_order_value
FROM sales
WHERE order_status = 'completed'
GROUP BY 1, 2
ORDER BY 1 DESC, 2