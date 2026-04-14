{% macro template_example(args) %}

   {% set myquery %}
    Select true as boolean
   {% endset %}

   {% if execute %}
     {% set result = run_query(myquery).columns[0].values()[0] %}
     {{ log('SQL result - '~result, info=true)}}

     Select {{ result }} as _is_real 
     from a_real_table
   {% endif %}
      
{% endmacro %} 