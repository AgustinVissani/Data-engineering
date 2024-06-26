{{
  config(
    materialized='table'
  )
}}

WITH stg_sqlserver__promos AS (
    SELECT *
    FROM {{ ref('stg_sqlserver__promos') }}
)

SELECT
    promo_id,
    promo_name,
    discount_usd,
    status_id,
    status,
    _fivetran_synced_utc
FROM stg_sqlserver__promos
