{{ config(
    materialized='table'
    ) 
}}

WITH dim_addresses AS (
    SELECT DISTINCT *
    FROM {{ ref('stg_sqlserver__addresses') }}
)

SELECT 
    ADDRESS_ID,
    ZIPCODE,
    COUNTRY,
    ADDRESS,
    STATE,
    _FIVETRAN_SYNCED_UTC
FROM dim_addresses
