with
src_budget as (select * from {{ source("_google_sheets__sources", "budget") }}),

renamed_casted as (
    select
        {{ dbt_utils.generate_surrogate_key(['_row']) }} AS budget_id,
        {{ dbt_utils.generate_surrogate_key(['product_id']) }} AS product_id,
        quantity as quantity_sold_expected,
        month,
        convert_timezone('UTC', _fivetran_synced) as _fivetran_synced_utc
    from src_budget
)

select *
from renamed_casted
