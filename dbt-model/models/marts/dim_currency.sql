with annual_financials as (
    select * from {{ ref('annual_income_statement') }}
),

final as (
    select distinct(currency) as currency
    from annual_financials
)

select * from final