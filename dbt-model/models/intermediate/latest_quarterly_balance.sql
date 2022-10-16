with quarterly_balance as (
    select * from {{ ref('quarterly_balance_statement') }}
),

quarterly_balance_ordered_by_date as (
    select
        *,
        row_number() over(partition by quarterly_balance.ticker order by quarterly_balance.date desc) as row_number
    
    from quarterly_balance
),

latest_quarterly_balance as (
    select
    *,
    current_date as price_date
    from quarterly_balance_ordered_by_date
    where row_number = 1
)

select * from latest_quarterly_balance