with parsed_balance as (
    select * from {{ ref('parsed_raw_balance') }}
),

rename_columns as (
    select
        ticker,
        currency,
        as_of_date as date,
        annualStockholdersEquity as stockholders_equity,
        annualPrepaidAssets as prepaid_assets,
        annualCashAndCashEquivalents as cash_and_cash_equivalents,
        annualInvestmentinFinancialAssets as investment_in_financial_assets,
        annualGoodwillAndOtherIntangibleAssets as goodwill_and_other_intangible_assets,
        annualAdditionalPaidInCapital as additional_paid_in_capital,
        annualTotalTaxPayable as total_tax_payable,
        annualCommonStockEquity as common_stock_equity,
        annualCashFinancial as cash_financial,
        annualTangibleBookValue as tangible_book_value,
        annualShareIssued as share_issued,
        annualCapitalStock as capital_stock,
        annualOtherPayable as other_payable,
        annualCurrentAssets as current_assets,
        annualTotalCapitalization as total_capitalization,
        annualCurrentLiabilities as current_liabilities,
        annualNetPPE as net_ppe,
        annualMachineryFurnitureEquipment as machinery_furniture_equipment,
        annualAccumulatedDepreciation as accumulated_depreciation,
        annualOtherShortTermInvestments as other_short_term_investments,
        annualTreasuryStock as treasury_stock,
        annualTreasurySharesNumber as treasury_shares_number,
        annualFinancialAssetsDesignatedasFairValueThroughProfitorLossTotal as financial_assets_designated_as_fair_value_through_profitor_loss_total,
        annualDividendsPayable as dividends_payable,
        annualRetainedEarnings as retained_earnings,
        annualCommonStock as common_stock,
        annualOrdinarySharesNumber as ordinary_shares_number,
        annualWorkingCapital as working_capital,
        annualAssetsHeldForSaleCurrent as assets_held_for_sale_current,
        annualTaxesReceivable as taxes_receivable,
        annualTotalLiabilitiesNetMinorityInterest as total_liabilities_net_minority_interest,
        annualCashCashEquivalentsAndShortTermInvestments as cash_cash_equivalents_and_short_term_investments,
        annualTotalAssets as total_assets,
        annualInvestedCapital as invested_capital,
        annualPayables as payables,
        annualAccountsPayable as accounts_payable,
        annualRestrictedCash as restricted_cash,
        annualTotalEquityGrossMinorityInterest as total_equity_gross_minority_interest,
        annualTotalNonCurrentAssets as total_non_current_assets,
        annualGrossPPE as gross_ppe,
        annualOtherReceivables as other_receivables,
        annualNetTangibleAssets as net_tangible_assets,
        annualReceivables as receivables,
        annualLongTermDebt as long_term_debt,
        annualTotalDebt as total_debt,
        annualGoodwill as goodwill,
        annualFinancialAssets as financial_assets,
        annualAccountsReceivable as accounts_receivable,
        annualPreferredStock as preferred_stock,
        annualNetDebt as net_debt,
        annualCashEquivalents as cash_equivalents,
        annualCurrentDebt as current_debt

    from parsed_balance
),

final as (
    select
        *,
        date as price_date
    from rename_columns
)

select * from final