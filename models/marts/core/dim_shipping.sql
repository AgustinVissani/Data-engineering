{{
  config(
    materialized='table'
  )
}}

WITH shipping_services AS (
    SELECT DISTINCT
        shipping_service_id,
        shipping_service_name,
        sum(shipping_cost_amount_usd) AS total_shipping_cost_usd,
        count(shipping_service_name) AS total_shipping_service,
        avg(shipping_cost_amount_usd) AS avg_shipping_service_cost

    FROM {{ ref('stg_sqlserver__orders') }}
    GROUP BY shipping_service_id, shipping_service_name
)

SELECT
    *
FROM shipping_services
