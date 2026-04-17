select 
    IsHoliday, 
    avg(weekly_sales) as avg_sales
from {{ ref('Walmart_fact_table') }}
group by 1

-- The sanity check is a quick, high-level query designed to verify that your data follows logical business patterns and that your joins are working as expected. 
-- In retail analysis, sales typically outperform non-holiday weeks (for example, holiday sales might average $1.3M compared to $1.19M on normal weeks)
-- It doesn't look for every small error; instead, it ensures the overall results are rational. 
-- This is the result i got 
-- ISHOLIDAY : TRUE -  17035.82318735039 (Holiday avg sales sould more that regular sales as per genral market)
-- ISHOLIDAY : FALSE - 15901.445069008367