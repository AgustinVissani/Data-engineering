{% snapshot users_snapshot %}

{{
    config(
      target_schema='snapshots',
      unique_key='user_id',
      strategy='timestamp',
      updated_at='_fivetran_synced',
        )
}}

select * from {{ source('_sqlserver_sources', 'users') }}


{% endsnapshot %}