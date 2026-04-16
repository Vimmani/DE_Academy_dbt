{{
    config(
        materialized='incremental',
        incremental_strategy = 'delete+insert',
        unique_key = ['DATE_ID'],
        database = 'WALMART_DB',
        schema = 'TRANSFORM_DATA'
    )
}}

Select *,
    current_timestamp() as UPDATE_DATE
 From {{ ref('department_clean_raw') }}

{% if is_incremental() %}
  WHERE DATE >= (SELECT MAX(UPDATE_DATE) FROM {{this}})
{% endif %}