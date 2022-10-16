with parsed_cashflows as (
    select * from {{ ref('parsed_raw_cashflow') }}
)

select distinct
    ticker,
    currency,
    as_of_date as date,
    annualFreeCashFlow as free_cash_flow

from parsed_cashflows