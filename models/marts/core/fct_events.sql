{{
  config(
    materialized='incremental',
    unique_key='order_id',
    on_schema_change='fail'
  )
}}

with events_per_user as (
    select * from {{ ref('int_events_per_user') }}
),

max_sync_time as (
    {% if is_incremental() %}
        select max(_fivetran_synced_utc) as max_synced
        from {{ this }}
    {% else %}
        select null as max_synced
    {% endif %}
),

join_time_events as (
    select
        e.*
    from events_per_user as e
    left join max_sync_time as m
        on 1=1
    {% if is_incremental() %}
      where e._fivetran_synced_utc > m.max_synced
    {% endif %}
)

select * from join_time_events
