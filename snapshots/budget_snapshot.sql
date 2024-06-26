{% snapshot budget_snapshot %}

{{
    config(
      target_schema='snapshots',
      unique_key='_row',
      strategy='timestamp',
      updated_at='_fivetran_synced'
    )
}}

select * from {{ source('_google_sheets__sources', 'budget') }}


{% endsnapshot %}