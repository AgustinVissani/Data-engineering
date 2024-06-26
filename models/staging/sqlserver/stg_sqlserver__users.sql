with snap_users as (
    select * 
    from {{ source("_sqlserver_sources", "users")  }}
    
),

src_sqlserver AS (
    SELECT
        user_id,
        first_name,
        last_name,
        address_id,
        phone_number,
        email,
        total_orders,
        to_date(created_at) as created_at_date,
        to_time(created_at) AS created_at_time_utc,
        to_date(updated_at) AS updated_at_date,
        to_time(updated_at) AS updated_at_time_utc,
        _fivetran_deleted,
        COALESCE(
            REGEXP_LIKE(phone_number, '^[0-9]{3}-[0-9]{3}-[0-9]{4}$') = true,
            false
        ) AS is_valid_phone_number,
        COALESCE(
            REGEXP_LIKE(
                email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$'
            ) = true,
            false
        ) AS is_valid_email_address,
        CONVERT_TIMEZONE('UTC', _fivetran_synced) AS _fivetran_synced_utc
    FROM snap_users

)

SELECT *
FROM src_sqlserver
