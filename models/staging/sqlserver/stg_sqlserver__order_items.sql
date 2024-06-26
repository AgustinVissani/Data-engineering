{{
  config(
    materialized='incremental',
    unique_key='order_id',
    on_schema_change='fail'
  )
}}

with source as (
    select * from {{ source("_sqlserver_sources", "order_items") }}
),
    src_sqlserver as (
        select
            order_id,
            {{ dbt_utils.generate_surrogate_key(['product_id']) }} AS product_id,
            quantity,
            _fivetran_deleted,
            convert_timezone('UTC', _fivetran_synced) as _fivetran_synced_utc
        from source
    {% if is_incremental() %}
      where
          _fivetran_synced_utc
          > (select max(_fivetran_synced_utc) from {{ this }})
    {% endif %}
    )

select *
from src_sqlserver
