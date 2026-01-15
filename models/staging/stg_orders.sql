WITH source AS (
    SELECT * FROM {{ source('ecommerce_raw', 'orders') }}
)

SELECT
    order_id,
    customer_id,
    order_date,
    LOWER(TRIM(status)) AS status
FROM source
WHERE order_id IS NOT NULL
  AND customer_id IS NOT NULL