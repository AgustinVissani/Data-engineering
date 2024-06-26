{{
  config(
    materialized='incremental',
    unique_key='order_id',
    on_schema_change='fail'
  )
}}
    
with

source_order_items as (
    select * from {{ ref('stg_sqlserver__order_items') }}
),

source_orders as (
    select * from {{ ref('stg_sqlserver__orders') }}
),

max_sync_time as (
    {% if is_incremental() %}
        select max(_fivetran_synced_utc) as max_synced
        from {{ this }}
    {% else %}
        select null as max_synced
    {% endif %}
),

join_order_Ordersitems as (
    select
        o.order_id,
        o.user_id,
        o.seller_id,
        o.shipping_service_id,
        o.shipping_cost_amount_usd,
        o.address_id,
        o.tracking_id,
        o.promo_id,
        o.order_total_usd,
        o.status_id,
        i.product_id,
        i.quantity,
        o.created_at_date,
        o.created_at_time_utc,
        o.estimated_delivery_at_date,
        o.estimated_delivery_at_time_utc,
        o.delivered_at_date,
        o.delivered_at_time_utc,
        o._fivetran_synced_utc
    from source_orders as o
    left join source_order_items as i
        on o.order_id = i.order_id
    left join max_sync_time as m
        on 1=1
    {% if is_incremental() %}
      where o._fivetran_synced_utc > m.max_synced
    {% endif %}
)


select * from join_order_Ordersitems

