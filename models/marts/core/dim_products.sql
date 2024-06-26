{{ config(
    materialized='table'
    ) 
}}

WITH dim_product AS (
    SELECT DISTINCT *
    FROM {{ ref('stg_sqlserver__product') }}
)

SELECT
    product_id,
    product_name,
    price_usd,
    inventory,
    _fivetran_synced_utc
FROM dim_product
