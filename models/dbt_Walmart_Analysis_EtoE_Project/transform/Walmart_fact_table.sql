{{
    config(
        materialized='table',
        database = 'WALMART_DB',
        schema = 'MART_DATA'
    )
}}

-- SELECT COUNT(*) FROM (
SELECT 
    S.STORE_ID,
    S.DEPT_ID,
    S.DATE_ID,
    S.STORE_SIZE,
    S.STORE_TYPE,
    D.WEEKLY_SALES,
    W.DATE,
    W.Isholiday,
    F.FUEL_PRICE,
    F.TEMPERATURE,
    F.UNEMPLOYMENT,
    F.CPI,
    F.MARKDOWN1,
    F.MARKDOWN2,
    F.MARKDOWN3,
    F.MARKDOWN4,
    F.MARKDOWN5,
    W.DATE AS INSERT_DATE,
    current_timestamp() AS UPDATE_DATE
FROM {{ ref('Walmart_store_dim') }} AS S
JOIN {{ ref('Walmart_date_dim') }} AS W ON S.DATE_ID =  W.DATE_ID
JOIN {{ ref('Walmart_department_dim') }} AS D ON S.DATE_ID =  D.DATE_ID
LEFT JOIN {{ ref('fact_clean_raw') }} AS F ON S.INSERT_DATE = F.DATE
-- )

