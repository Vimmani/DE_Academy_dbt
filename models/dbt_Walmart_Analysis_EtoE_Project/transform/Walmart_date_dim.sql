{{
    config(
        materialized='incremental',
        incremental_strategy = 'delete+insert',
        unique_key = 'DATE_ID',
        database = 'WALMART_DB',
        schema = 'TRANSFORM_DATA'
    )
}}

With store_date_Data as (
Select 
   DATE_ID,
   DATE,
   ISHOLIDAY,
   DATE AS INSERT_DATE,
   current_timestamp() AS UPDATE_DATE
From {{ ref('department_clean_raw') }}
)

Select * from store_date_Data

{% if is_incremental() %}
   Where INSERT_DATE >= (Select MAX(UPDATE_DATE) from {{ this }})
{% endif%}
