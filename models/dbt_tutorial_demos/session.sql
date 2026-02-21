{{ 
    config(
          materialized = 'table'
    )
}}

with session_src as 
(
    select 
    SESSION_ID,
    USER_ID,
    BROWSER,
    DEVICE_TYPE,
    b.country_name as country_name,
    b.continent as continent,
    b.currency as currency,
    START_TIME,
    END_TIME,
    PAGES_VISITED,
    current_timestamp As INSERT_DTS
    From {{source('session','SESSION_SRC')}} a 
    Left Join {{ref('country_code')}} b 
    on a.COUNTRY_CODE = b.COUNTRY_CODE
)
select * from session_src