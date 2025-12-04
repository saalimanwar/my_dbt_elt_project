{% macro calc_growth(current_value, previous_value) %}
    case
        when {{ previous_value }} = 0 or {{ previous_value }} is null then null
        else (({{ current_value }} - {{ previous_value }}) / {{ previous_value }}) * 100
    end
{% endmacro %}
