{{
    config(
        materialized='table',
        database='WALMART_DB',
        schema='RAW_DATA',
        alias='DEPARTMENT_CLEAN_RAW_DATA'
    )
}}

select
    value:c1::int as store_id,
    value:c2::string as dept_id,
    value:c3::string as date,
    {{ dbt_utils.generate_surrogate_key(['store_id', 'dept_id', 'date'])}}::string as date_id,
    value:c4::string as weekly_sales,
    value:c5::string as Isholiday,
    (metadata$filename)::string as File_name
from {{ source('walmart_source', 'DEPARTMENT_RAW_DATA') }}