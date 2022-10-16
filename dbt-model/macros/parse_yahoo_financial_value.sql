{% macro parse_yahoo_financial_value(yahoo_name, cte_name='') %}
/* start annual net income */
unparsed_{{cte_name}} as (
    select
        jsonb_array_elements(data_json->'{{yahoo_name}}') as blob,
        data_json->'meta'->'symbol'->>0 as ticker
    from split_result
),
{{cte_name}} as (
    select
        ((blob->>'reportedValue')::json->>'raw')::decimal as {{yahoo_name}},
        (blob->>'asOfDate')::date as as_of_date,
        (blob->>'currencyCode')::text as currency,
        ticker
    from unparsed_{{cte_name}}
),
/* end annual net income (todo: make a macro for this) */
{% endmacro %}