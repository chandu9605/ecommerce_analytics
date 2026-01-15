{{
    config(
        materialized='view',
        tags=['staging', 'customers']
    )
}}

WITH source AS (
    SELECT * FROM {{ source('ecommerce_raw', 'customers') }}
),

cleaned AS (
    SELECT
        customer_id,
        TRIM(LOWER(first_name)) AS first_name,
        TRIM(LOWER(last_name)) AS last_name,
        LOWER(TRIM(email)) AS email,
        created_at,
        updated_at
    FROM source
    WHERE customer_id IS NOT NULL
      AND first_name IS NOT NULL  -- Filter out invalid records
      AND last_name IS NOT NULL
)

SELECT * FROM cleaned