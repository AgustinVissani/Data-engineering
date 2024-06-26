with snap_sellers as (
    select * 
    from {{ ref("sellers_snapshot") }}
),

src_sellers as (
    select
        {{ dbt_utils.generate_surrogate_key(['seller_id']) }} AS seller_id,
        first_name::varchar(50) AS first_name,
        last_name::varchar(50) AS last_name,
        CAST(salary AS decimal(10, 2)) AS salary,
        commission::int AS commission,
        {{ dbt_utils.generate_surrogate_key(['address_id']) }} AS address_id,
        TO_DATE(contract_start_date) AS contract_start_date_at_date,
        TO_TIME(contract_start_date) AS contract_start_date_at_time_utc,
        TO_DATE(contract_end_date) AS contract_end_date_at_date,
        TO_TIME(contract_end_date) AS contract_end_date_at_time_utc,
        convert_timezone('UTC', _fivetran_synced) AS _fivetran_synced_utc,
        dbt_valid_to
     from snap_sellers
),

renamed_casted AS (
    SELECT *
    FROM src_sellers
)

SELECT * FROM renamed_casted
WHERE dbt_valid_to IS NULL
