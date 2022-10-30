with balance as (
    select * from {{ ref('fact_balance_statement') }}
),

latest_stock_price_in_year as (
    select * from {{ ref('latest_stock_price_in_year') }}
),

income as (
    select * from {{ ref('fact_income_statement') }}
),

balance_with_year as (
    select
        *,
        EXTRACT(YEAR FROM balance.date) as year
    from balance
),

final as (
    select
        stock_price.ticker,
        balance.price_date as date,
        stock_price.year,
        stock_price.currency,
        stock_price.close,
        stock_price.open,
        stock_price.low,
        stock_price.high,
        balance.ordinary_shares_number,
        (stock_price.close * balance.ordinary_shares_number) as market_capitalization,
        income.net_income

    from balance_with_year balance
    inner join latest_stock_price_in_year stock_price on stock_price.ticker = balance.ticker and stock_price.year = balance.year
    left outer join income on stock_price.ticker = income.ticker and stock_price.year = income.year

)

select * from final