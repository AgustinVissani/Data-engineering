with snap_product as (
    select * 
    from {{ ref("products_snapshot") }}
),

src_sqlserver as (
        select
            {{ dbt_utils.generate_surrogate_key(['product_id']) }} AS product_id,
            name as product_name,
            price as price_usd,
            inventory,
            _fivetran_deleted,
            convert_timezone('UTC', _fivetran_synced) as _fivetran_synced_utc,
            dbt_valid_to

        from snap_product
        where _fivetran_deleted is null

        union all

        select

           'No products' as product_id,
            'No products' as product_name,
            0 as price_usd,
            '0' as inventory,
            null as _fivetran_deleted,
            null as _fivetran_synced_utc,
            null as dbt_valid_to
    )

select *
from src_sqlserver
WHERE dbt_valid_to IS NULL
