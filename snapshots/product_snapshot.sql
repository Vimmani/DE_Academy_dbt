{%  snapshot product_snapshot  %}

{{
    config(
        strategy = 'check',
        unique_key = 'PATIENT_ID',
        -- check_cols = ['PATIENT_NAME','PATIENT_CONTACT_NUMBER','PATIENT_EMAIL_ID','PATIENT_ADDRESS']
    )
}}
Select * from {{source('product','PRODUCT_SRC')}}

{% endsnapshot %}