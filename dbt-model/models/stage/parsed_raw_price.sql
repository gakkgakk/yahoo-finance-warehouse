with price as (
    select * from {{ source('yahoo_financials', '_airbyte_raw_price') }}
),

result as (
    select jsonb_array_elements(_airbyte_data->'chart'->'result') as result
    from price
),

normalized_results as (
    select
        result->'meta'->>'symbol' as ticker,
        result->'meta'->>'currency' as currency,
        cast(jsonb_array_elements(result->'timestamp') as int) as unix_epoch,
        cast(jsonb_array_elements(result->'indicators'->'quote'->0->'low') as decimal) as low,
        cast(jsonb_array_elements(result->'indicators'->'quote'->0->'high') as decimal) as high,
        cast(jsonb_array_elements(result->'indicators'->'quote'->0->'open') as decimal) as open,
        cast(jsonb_array_elements(result->'indicators'->'quote'->0->'close') as decimal) as close
    from result
),

final as (
    select
        ticker, currency,
        cast( {{ dbt_date.from_unixtimestamp('unix_epoch') }} as date) as date,
        ROUND(low, 2) as low,
        ROUND(high, 2) as high,
        ROUND(open, 2) as open,
        ROUND(close, 2) as close
    
    from normalized_results
)

select * from final