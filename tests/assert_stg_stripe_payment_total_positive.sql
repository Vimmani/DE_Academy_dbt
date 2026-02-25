Select 
     order_id,
     SUM(amount) as total_amount
From {{ ref('stg_stripe__payments') }}
Group by order_id
Having  total_amount < 0  

