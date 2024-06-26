{{
  config(
    materialized='table'
  )
}}

WITH stg_users AS 
(
    SELECT * 
    FROM {{ ref('stg_sqlserver__users') }}
)

    select     
    user_id,
    first_name,
    last_name,
    address_id,
    phone_number,
    email,
    created_at_date,
    created_at_time_utc,
    updated_at_date,
    updated_at_time_utc,
    _fivetran_synced_utc
    from stg_users