{{
    config(
        materialized='table',
        database='WALMART_DB',
        schema='RAW_DATA',
        alias='FACT_CLEAN_RAW_DATA'
    )
}}

select
    value:c1::int as store_id,
    value:c2::string as date,
    value:c3::string as temperature,
    value:c4::string as fuel_price,
    value:c5::string as markdown1,
    value:c6::string as markdown2,
    value:c7::string as markdown3,
    value:c8::string as markdown4,
    value:c9::string as markdown5,
    value:c10::string as CPI,
    value:c11::string as unemployment,
    value:c12::string as Isholiday,
    (metadata$filename)::string as File_name
from {{ source('walmart_source', 'FACT_RAW_DATA') }}