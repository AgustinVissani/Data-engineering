{% snapshot orders_items_snapshot %}

{{
    config(
      target_schema='snapshots',
      unique_key='order_id',
      strategy='timestamp',
      updated_at='_fivetran_synced',
        )
}}

select * from {{ source('_sqlserver_sources', 'order_items') }}


{% endsnapshot %}