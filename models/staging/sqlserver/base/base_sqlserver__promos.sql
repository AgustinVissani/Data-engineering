with source as (
    (select * from {{ source("_sqlserver_sources", "promos") }})
),

src_sqlserver as (
        select
            case
                when promo_id is null or promo_id = '' then 'unknown' else {{ normalize_promo_name('promo_id') }}
            end as promo_name,
            discount as discount_usd,
            status,
            _fivetran_deleted,
            convert_timezone('UTC', _fivetran_synced) as _fivetran_synced_utc
        from source
        where _fivetran_deleted is null
        union all
        select
            'unknown' as promo_name,
            0 as discount_usd,
            'inactive' as status,
            null as _fivetran_deleted,
            null as _fivetran_synced_utc,
    )

select *
from src_sqlserver
