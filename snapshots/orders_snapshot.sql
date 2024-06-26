{% snapshot orders_snapshot %}

{{
    config(
      target_schema='snapshots',
      unique_key='order_id',
      strategy='timestamp',
      updated_at='_fivetran_synced_utc',
        )
}}

select * from {{ ref('base_sqlserver__orders') }}


{% endsnapshot %}