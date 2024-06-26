{{
  config(
    materialized='table'
  )
}}

WITH status_orders AS (
    SELECT DISTINCT
        status_id,
        status
    FROM {{ ref('stg_sqlserver__orders') }}
    GROUP BY status_id, status
)

SELECT
    status_id,
    status
FROM status_orders
