--This may not work because the table we are trying to union should have same number of columns which we dont have in JAFFLE_SHOP schema
{{ union_tables_by_prefix( database='raw', schema='JAFFLE_SHOP', prefix='orders__') }}
