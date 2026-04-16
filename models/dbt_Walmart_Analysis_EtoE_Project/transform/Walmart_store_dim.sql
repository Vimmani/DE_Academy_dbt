{{
    config(
        materialized='incremental',
        incremental_strategy = 'delete+insert',
        unique_key = ['DATE_ID'],
        database='WALMART_DB',
        schema='TRANSFORM_DATA'
    )
}}

With joined_store_dept_data as (
    SELECT
    D.DATE_ID,
    D.STORE_ID,
    D.DEPT_ID,
    S.STORE_TYPE,
    S.STORE_SIZE,
    D.DATE AS INSERT_DATE,
    current_timestamp() as UPDATE_DATE
FROM {{ ref('department_clean_raw') }} AS D
LEFT JOIN {{ ref('stores_clean_raw') }} AS S
ON D.STORE_ID = S.STORE_ID 
)

SELECT * FROM joined_store_dept_data

{% if is_incremental() %}
 -- Here we are assuming that date coming from departemnt is true and not gonna change. IF it changes we need implent the logic that was commented belwo
  WHERE INSERT_DATE >= (SELECT MAX(UPDATE_DATE) FROM {{this}})
{% endif %}


-- SELECT
--     s.STORE_ID,
--     s.DEPT_ID,
--     s.STORE_TYPE,
--     s.STORE_SIZE,
    
--     {% if is_incremental() %}
--     -- The COALESCE function returns the first non-null value in the list of columns provided.
--     -- It first looks at t.INSERT_DATE (The date already existing in your Target table).
--     -- If t.INSERT_DATE is NULL (meaning this is a brand-new record), it falls back to s.SOURCE_DATE (the date coming from your Source data).
--     -- The result is then saved as the final INSERT_DATE     
--         -- Keeps the original date from the first time this store/dept combo appeared
--         coalesce(t.INSERT_DATE, s.SOURCE_DATE) as INSERT_DATE,
--     {% else %}
--         s.SOURCE_DATE as INSERT_DATE,
--     {% endif %}
    
--     current_timestamp() as UPDATE_DATE
    
-- FROM joined_store_dept_data s

-- {% if is_incremental() %}
--     LEFT JOIN {{ this }} t 
--         ON s.STORE_ID = t.STORE_ID 
--         AND s.DEPT_ID = t.DEPT_ID

--     -- Standard incremental check
--     WHERE s.SOURCE_DATE >= (SELECT MAX(UPDATE_DATE)::date FROM {{ this }})
-- {% endif %}
     