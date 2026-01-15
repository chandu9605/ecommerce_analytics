WITH customers AS (
    SELECT * FROM {{ ref('stg_customers') }}
),

order_details AS (
    SELECT * FROM {{ ref('int_order_details') }}
),

aggregated AS (
    SELECT
        c.customer_id,
        c.first_name,
        c.last_name,
        c.email,
        COUNT(DISTINCT od.order_id) AS total_orders,
        SUM(od.line_total) AS lifetime_value,
        MIN(od.order_date) AS first_order_date,
        MAX(od.order_date) AS last_order_date
    FROM customers c
    LEFT JOIN order_details od
        ON c.customer_id = od.customer_id
    GROUP BY 1, 2, 3, 4
)

SELECT * FROM aggregated