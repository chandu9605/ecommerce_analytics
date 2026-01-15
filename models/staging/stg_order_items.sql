WITH source AS (
    SELECT * FROM {{ source('ecommerce_raw', 'order_items') }}
)

SELECT
    order_item_id,
    order_id,
    product_id,
    quantity,
    price,
    (quantity * price) AS line_total
FROM source
WHERE order_item_id IS NOT NULL