{% macro qa_select_all_not_null_gem(model, col) %}

select * from {{model}} where {{col}} is not null
{% endmacro %}
