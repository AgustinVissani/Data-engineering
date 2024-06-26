{{
  config(
    materialized='table'
  )
}}

WITH event_types AS (
    SELECT DISTINCT
        event_type_id,
        event_type
    FROM {{ ref('stg_sqlserver__events') }}
    GROUP BY event_type_id, event_type
)

SELECT
    event_type_id,
    event_type
FROM event_types
