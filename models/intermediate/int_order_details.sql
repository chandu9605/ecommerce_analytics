{{
    config(
        materialized='view'
    )
}}

WITH orders AS (
    SELECT * FROM {{ ref('stg_orders') }}
),

order_items AS (
    SELECT * FROM {{ ref('stg_order_items') }}
),

products AS (
    SELECT * FROM {{ ref('stg_products') }}
),

joined AS (
    SELECT
        oi.order_item_id,
        o.order_id,
        o.customer_id,
        o.order_date,
        o.status AS order_status,
        p.product_id,
        p.product_name,
        p.category AS product_category,
        oi.quantity,
        oi.price AS unit_price,
        oi.line_total
    FROM order_items oi
    INNER JOIN orders o
        ON oi.order_id = o.order_id
    INNER JOIN products p
        ON oi.product_id = p.product_id
)

SELECT * FROM joined