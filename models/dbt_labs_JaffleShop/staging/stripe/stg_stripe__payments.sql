select
    id as payment_id,
    orderid as order_id,
    paymentmethod as payment_method,
    status,

    -- amount is stored in cents, convert it to dollars
    -- refering macro for this conversion
    {{ cents_to_dollars('amount') }} as amount,
    created as created_at

--from RAW.STRIPE.PAYMENT
from {{source('stripe','PAYMENT')}}