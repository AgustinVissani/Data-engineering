{{
  config(
    materialized='incremental',
    unique_key='event_id',
    on_schema_change='fail'
  )
}}

with
    source as (select * from {{ source("_sqlserver_sources", "events") }}),
    src_sqlserver as (
        select
            event_id,
            page_url,
            event_type,
            {{ dbt_utils.generate_surrogate_key(['event_type']) }} AS event_type_id,
            user_id,
            COALESCE({{ dbt_utils.generate_surrogate_key(['product_id']) }}, 'no-product') AS product_id,
            session_id,
            created_at,
            COALESCE({{ dbt_utils.generate_surrogate_key(['order_id']) }}, 'no-order') AS order_id,
            _fivetran_deleted,
            convert_timezone('UTC', _fivetran_synced) as _fivetran_synced_utc
        from source
        {% if is_incremental() %}
        where _fivetran_synced_utc > (select max(_fivetran_synced_utc) from {{ this }})
        {% endif %}
    )

select *
from src_sqlserver

