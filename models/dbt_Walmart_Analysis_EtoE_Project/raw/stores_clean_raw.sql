{{
    config(
        materialized='table',
        database='WALMART_DB',
        schema='RAW_DATA',
        alias='STORES_CLEAN_RAW_DATA'
    )
}}

select
    value:c1::int as store_id,
    value:c2::string as store_type,
    value:c3::string as store_size,
    (metadata$filename)::string as File_name
from {{ source('walmart_source', 'STORES_RAW_DATA') }}