with stock_price as (
    select * from {{ ref('fact_stock_price') }}
),

stock_price_with_year as (
    select
        *,
        row_number() over(partition by stock_price.ticker, EXTRACT(YEAR FROM stock_price.date) order by stock_price.date desc) as row_number,
        EXTRACT(YEAR FROM stock_price.date) as year
    from stock_price
),

final as (
    select *
    from stock_price_with_year
    where row_number = 1
)

select * from final