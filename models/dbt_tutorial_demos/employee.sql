
-- Since we haven't defined it to be table by default dbt will create a view called employee with the data from employee_raw table in snowflake
-- If you want to define it as table specifically add configurationa as below

{{
    config
    (
        materialized = 'table'
    )
}}

with employee_transform as 
(
    select
    EMPID as emp_id,
    split_part(NAME,' ',1)  as emp_firstname,
    split_part(NAME,' ',2)  as emp_lastname,
    SALARY as emp_salary,
    HIREDATE as emp_hiredate,
    split_part(ADDRESS,',',1) as emp_street,
    split_part(ADDRESS,',',2) as emp_city,
    split_part(ADDRESS,',',3) as emp_country,
    split_part(ADDRESS,',',4) as emp_zipcode
    --from DBT_DB.PUBLIC.EMPLOYEE_RAW 
    from {{source('employee','EMPLOYEE_RAW')}} --fetching the source table form yaml file
)

select * from employee_transform