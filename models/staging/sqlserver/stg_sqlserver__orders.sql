
{{
  config(
    materialized='incremental',
    unique_key='order_id',
    on_schema_change='fail'
  )
}}


with base_orders as (
    select * 
    from {{ ref("base_sqlserver__orders") }}
),

src_sqlserver as (
    select
        order_id,
        shipping_service_name,
        {{ dbt_utils.generate_surrogate_key(['shipping_service_name']) }} AS shipping_service_id,
        NULLIF({{ dbt_utils.generate_surrogate_key(['seller_id']) }}, '') AS seller_id,
        shipping_cost_amount_usd,
        {{ dbt_utils.generate_surrogate_key(['address_id'])}} AS address_id,
        {{ dbt_utils.generate_surrogate_key(['promo_id']) }} AS promo_id,
        created_at_date,
        created_at_time_utc,
        estimated_delivery_at_date,
        estimated_delivery_at_time_utc,
        delivered_at_date,
        delivered_at_time_utc,
        order_cost_usd,
        user_id,
        order_total_usd,
        COALESCE({{ dbt_utils.generate_surrogate_key(['tracking_id'])}}, 'no-tracking') AS tracking_id,
        status,
        {{ dbt_utils.generate_surrogate_key(['status'])}} AS status_id,
        _fivetran_deleted,
        _fivetran_synced_utc
    from base_orders

    {% if is_incremental() %}
      where  _fivetran_synced_utc > (select max(_fivetran_synced_utc) from {{ this }})
    {% endif %}

)

select * from src_sqlserver
