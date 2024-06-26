{{
  config(
    materialized='incremental',
    unique_key='order_id',
    on_schema_change='fail'
  )
}}

with source as (
    select * from {{ source("_sqlserver_sources", "orders") }}
),

src_sqlserver as (
    select
        order_id,
        seller_id,
        shipping_cost as shipping_cost_amount_usd,
        address_id,
        case
            when shipping_service is null or shipping_service = ''
            then 'unknown'
            else lower(shipping_service)
        end as shipping_service_name,
        case
            when promo_id is null or promo_id = '' 
            then 'unknown' 
            else {{ normalize_promo_name('promo_id') }}
        end as promo_id,
        TO_DATE(created_at) as created_at_date,
        TO_TIME(created_at) as created_at_time_utc,
        TO_DATE(estimated_delivery_at) as estimated_delivery_at_date,
        TO_TIME(estimated_delivery_at) as estimated_delivery_at_time_utc,
        TO_DATE(delivered_at) as delivered_at_date,
        TO_TIME(delivered_at) as delivered_at_time_utc,
        order_cost as order_cost_usd,
        user_id,
        order_total as order_total_usd,
        tracking_id,
        case
            when status is null or status = '' 
            then 'unknown' 
            else lower(status)
        end as status,
        _fivetran_deleted,
        convert_timezone('UTC', _fivetran_synced) as _fivetran_synced_utc
    from source
    {% if is_incremental() %}
    where _fivetran_synced_utc > (select max(_fivetran_synced_utc) from {{ this }})
    {% endif %}
)

select *
from src_sqlserver

