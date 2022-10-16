{% macro parse_raw_yahoo_financial_json(source_name, table_name, value_list) %}
with financials as (
    select * from {{ source(source_name, table_name) }}
),

timeseries as (
    select _airbyte_data->'timeseries'->'result' as result
    from financials
),

split_result as (
    select
        jsonb_array_elements(result) as data_json
    from timeseries
),

{% for value in value_list %}
{{parse_yahoo_financial_value(value, value)}}
{% endfor %}

final as (
    select
        {{value_list[0]}}.ticker
        , {{value_list[0]}}.as_of_date
        , {{value_list[0]}}.currency
        {% for value in value_list %}
        , {{value}}.{{value}}
        {% endfor %}

    from {{value_list[0]}}
    {% for value in value_list[1:] %}
    left outer join {{value }} on (
        {{value_list[0]}}.as_of_date = {{value}}.as_of_date AND
        {{value_list[0]}}.ticker = {{value}}.ticker
    )
    {% endfor %}
)

select * from final
{% endmacro %}