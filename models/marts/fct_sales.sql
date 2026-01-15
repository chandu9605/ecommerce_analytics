{{
    config(
        materialized='table',
        tags=['marts', 'facts']
    )
}}

WITH order_details AS (
    SELECT * FROM {{ ref('int_order_details') }}
)

SELECT
    order_item_id AS sales_key,
    order_id,
    customer_id,
    product_id,
    order_date,
    order_status,
    product_name,
    product_category,
    quantity,
    unit_price,
    line_total
FROM order_details