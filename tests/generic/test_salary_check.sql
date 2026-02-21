-- Below statement is a starting block for writing a test case it should have '{%  %}' in that you start with 'test' keyword followed by name of the
-- test case 'salary_check' with parameters 'model' and 'column_name'. These parameters represet the model and column on which you wan tto run the test
-- and test case should always have an end block 
--TEST : Make sure that salaray column shouldn't have value less than 10000

{% test salary_check(model,column_name) %}

select * from
{{ model }}
where {{ column_name }} < 10000

{% endtest %}