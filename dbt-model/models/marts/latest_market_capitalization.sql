with balance as (
    select * from {{ ref('quarterly_balance_statement') }}
),

stock_price as (
    select * from {{ ref('fact_stock_price') }}
),

stock_price_ordered_by_date as (
    select
        stock_price.ticker,
        stock_price.date,
        stock_price.close,
        row_number() over(partition by stock_price.ticker order by stock_price.date desc) as row_number

    from stock_price
),

latest_stock_price as (
    select * from stock_price_ordered_by_date
    where row_number = 1
),

number_of_shares_ordered_by_date as (
    select
        balance.ticker,
        balance.date,
        balance.ordinary_shares_number,
        row_number() over(partition by balance.ticker order by balance.date desc) as row_number

    from balance

),

latest_number_of_shares as (
    select * from number_of_shares_ordered_by_date
    where row_number = 1
),

final as (
    select
        latest_stock_price.ticker,
        latest_number_of_shares.date,
        latest_stock_price.close,
        latest_number_of_shares.ordinary_shares_number,
        (latest_stock_price.close * latest_number_of_shares.ordinary_shares_number) as market_capitalization

    from latest_stock_price
    left outer join latest_number_of_shares on latest_stock_price.ticker = latest_number_of_shares.ticker

)

select * from final