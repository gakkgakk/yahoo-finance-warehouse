with balance as (
    select * from {{ ref('annual_balance_statement') }}
),

latest_quarterly_balance as (
    select {{ dbt_utils.star(from=ref('latest_quarterly_balance'), except=['row_number']) }}
    from {{ ref('latest_quarterly_balance') }}
),

final as (
    select * from balance
    union
    select * from latest_quarterly_balance
)

select * from final