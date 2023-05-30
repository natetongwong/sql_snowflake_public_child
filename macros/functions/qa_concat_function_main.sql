{% macro qa_concat_function_main(param_1, param_2='hello') %}
concat({{param_1}}, {{param_2}})
{% endmacro %}

 {% macro combine_multiple_tables(table_1, table_2, table_3, table_4, table_5, col_table_1) %}
select * from {{table_1}} 
    where {{col_table_1}} != (select count(*) from {{table_2}} ) + 
        (select count(*) from {{table_3}} ) + 
            (select count(*) from {{table_4}} ) + 
                (select count(*) from {{table_5}} )
{% endmacro %}

 