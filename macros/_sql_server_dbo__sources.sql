{{
    codegen.generate_source(
        schema_name = 'SQL_SERVER_DBO',
        database_name = 'ALUMNO4_DEV_BRONZE_DB',
        table_names = ['addresses', 'events', 'orders', 'order_items', 'products', 'promos', 'users' ],
        generate_columns = True,
        include_descriptions=True,
        include_data_types=True,
        name='desarrollo',
        include_database=True,
        include_schema=True
        )
}}

{{
    codegen.generate_source(
        schema_name = 'CORE',
        database_name = 'ALUMNO4_DEV_GOLD_DB',
        table_names = ['dim_status_orders', 'dim_products', 'dim_promos', 'dim_users', 'fct_orders', 'fct_events' ],
        generate_columns = True,
        include_descriptions=True,
        include_data_types=True,
        name='_core',
        include_database=True,
        include_schema=True
        )
}}



{{
    codegen.generate_source(
        schema_name = 'CORE',
        database_name = 'ALUMNO4_DEV_GOLD_DB',
        table_names = ['dim_addresses', 'dim_event_types','dim_month', 'dim_time', 'dim_shipping', 'dim_status_promos' ],
        generate_columns = True,
        include_descriptions=True,
        include_data_types=True,
        name='_core',
        include_database=True,
        include_schema=True
        )
}}

{{
    codegen.generate_source(
        schema_name = 'DBT',
        database_name = 'ALUMNO4_DEV_GOLD_DB',
        table_names = ['dm_marketing' , 'dm_budget_performance' ],
        generate_columns = True,
        include_descriptions=True,
        include_data_types=True,
        name='_dbt_models_marketing',
        include_database=True,
        include_schema=True
        )
}}

{{
    codegen.generate_source(
        schema_name = 'DBT',
        database_name = 'ALUMNO4_DEV_GOLD_DB',
        table_names = ['dm_product' ],
        generate_columns = True,
        include_descriptions=True,
        include_data_types=True,
        name='_dbt_models_product',
        include_database=True,
        include_schema=True
        )
}}