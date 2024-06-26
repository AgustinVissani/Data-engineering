with
source as (select * from {{ source("_sqlserver_sources", "addresses") }}),

src_sqlserver as (
    select
        address_id,
        zipcode,
        country,
        address,
        state,
        _fivetran_deleted,
        convert_timezone('UTC', _fivetran_synced) as _fivetran_synced_utc
    from source
    where _fivetran_deleted is null
    union all
    select
        'no-address' as address_id,
        '0' as zipcode,
        'no-exist' as country,
        'no-exist' as address,
        'no-exist' as state,
        null::boolean as _fivetran_deleted,
        null::timestamp as _fivetran_synced_utc
)

select *
from src_sqlserver
