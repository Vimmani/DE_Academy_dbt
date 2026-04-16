{{
    config(
        materialized='incremental',
        incremental_strategy = 'delete+insert',
        unique_key = 'DATE_ID',
        database = 'WALMART_DB',
        schema = 'TRANSFORM_DATA'
    )
}}

Select 
   {{ dbt_utils.generate_surrogate_key(['STORE_ID', 'DEPT_ID', 'DATE'])}} as DATE_ID,
   DATE,
   ISHOLIDAY,
   DATE AS INSERT_DATE,
   current_timestamp AS UPDATE_DATE
From {{ ref('department_clean_raw') }}

{% if is_incremental() %}
 
   Where INSERT_DATE >= (Select MAX(UPDATE_DATE)::date from {{ this }}))

{% endif%}
