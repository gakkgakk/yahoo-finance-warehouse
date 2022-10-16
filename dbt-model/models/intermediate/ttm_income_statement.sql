with parsed_annual_income_statement as (
    select * from {{ ref('parsed_raw_ttm_income') }}
),

rename_columns as (
    select
        ticker,
        currency,
        as_of_date as date,
        trailingNetIncome as net_income,
        trailingTotalRevenue as total_revenue,
        trailingTotalExpenses as total_expenses,
        trailingCostOfRevenue as cost_of_revenue,
        trailingGrossProfit as gross_profit,
        trailingOperatingExpense as operating_expense,
        trailingEBIT as ebit,
        trailingEBITDA as ebitda,
        trailingNetIncomeCommonStockholders as net_income_common_stockholders,
        trailingOperatingRevenue as operating_revenue,
        trailingResearchAndDevelopment as research_and_development,
        trailingDilutedEPS as diluted_eps,
        trailingBasicEPS as basic_eps,
        trailingOperatingIncome as operating_income,
        trailingAmortization as amortization

    from parsed_annual_income_statement
),

final as (
    select
        *,
        current_date as price_date
    from rename_columns
)

select * from final