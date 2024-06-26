{{
  config(
    materialized='table'
  )
}}

WITH status_promos AS (
    SELECT DISTINCT
        status_id,
        status
    FROM {{ ref('stg_sqlserver__promos') }}
    GROUP BY status_id, status
)

SELECT
    status_id,
    status
FROM status_promos
