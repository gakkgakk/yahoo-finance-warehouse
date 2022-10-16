with parsed_annual_income_statement as (
    select * from {{ ref('parsed_raw_income') }}
),

rename_columns as (
    select
        ticker,
        currency,
        as_of_date as date,
        annualNetIncome as net_income,
        annualTotalRevenue as total_revenue,
        annualTotalExpenses as total_expenses,
        annualCostOfRevenue as cost_of_revenue,
        annualGrossProfit as gross_profit,
        annualOperatingExpense as operating_expense,
        annualEBIT as ebit,
        annualEBITDA as ebitda,
        annualNetIncomeCommonStockholders as net_income_common_stockholders,
        annualOperatingRevenue as operating_revenue,
        annualResearchAndDevelopment as research_and_development,
        annualDilutedEPS as diluted_eps,
        annualBasicEPS as basic_eps,
        annualOperatingIncome as operating_income,
        annualAmortization as amortization

    from parsed_annual_income_statement
),

final as (
    select
        *,
        date as price_date

    from rename_columns
)

select * from final