with
    payments as (
        select * from {{ ref("stg_stripe__payments") }} where status = 'success'
    ),

    pivoted as (
        {%- set payment_methods = ["bank_transfer","Coupon","credit_card","gift_card"] -%}
        select
            order_id,
            {% for item in payment_methods %}
               sum( case when payment_method = '{{item}}' then amount else 0 end ) as {{ item }}_Amount
                {%- if not loop.last -%}
                    ,
                {%- endif -%}
            {% endfor %}
        from {{ ref("stg_stripe__payments") }}
        group by order_id
    )
select * from pivoted

    {# If it has to be written in pure aql we implement as below but with help of jinja we used for loop and reduced the lines of code above.
pivoted as (
select order_id,
  SUM(case when payment_method = 'bank_transfer' Then amount else 0 end ) as Bank_Transfer_Amount,
  SUM(case when payment_method = 'Coupon' Then amount else 0 end ) as Coupon_Amount,
  SUM(case when payment_method = 'credit_card' Then amount else 0 end ) as Credit_Card_Amount,
  SUM(case when payment_method = 'gift_card' Then amount else 0 end ) as Gift_Card_Amount,
from {{ ref('stg_stripe__payments') }}
group by order_id
)
Select * from pivoted#}
    
