Select 
     customer_id,
     order_Date,
     --making use of 'generate_surrogate_key' macro from dbutils package to generate surrogate unique key using two columns
     {{ dbt_utils.generate_surrogate_key(['customer_id', 'order_Date']) }} as primary_key,
     count(*) as c 
From {{ ref('stg_jaffle_shop__orders') }}
Group by 1,2