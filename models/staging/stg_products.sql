WITH source AS (
    SELECT * FROM {{ source('ecommerce_raw', 'products') }}
)

SELECT
    product_id,
    TRIM(product_name) AS product_name,
    TRIM(category) AS category,
    unit_price
FROM source
WHERE product_id IS NOT NULL