with parsed_balance as (
    select * from {{ ref('parsed_raw_quarterly_balance') }}
),

rename_columns as (
    select
        ticker,
        currency,
        as_of_date as date,
        quarterlyStockholdersEquity as stockholders_equity,
        quarterlyPrepaidAssets as prepaid_assets,
        quarterlyCashAndCashEquivalents as cash_and_cash_equivalents,
        quarterlyInvestmentinFinancialAssets as investment_in_financial_assets,
        quarterlyGoodwillAndOtherIntangibleAssets as goodwill_and_other_intangible_assets,
        quarterlyAdditionalPaidInCapital as additional_paid_in_capital,
        quarterlyTotalTaxPayable as total_tax_payable,
        quarterlyCommonStockEquity as common_stock_equity,
        quarterlyCashFinancial as cash_financial,
        quarterlyTangibleBookValue as tangible_book_value,
        quarterlyShareIssued as share_issued,
        quarterlyCapitalStock as capital_stock,
        quarterlyOtherPayable as other_payable,
        quarterlyCurrentAssets as current_assets,
        quarterlyTotalCapitalization as total_capitalization,
        quarterlyCurrentLiabilities as current_liabilities,
        quarterlyNetPPE as net_ppe,
        quarterlyMachineryFurnitureEquipment as machinery_furniture_equipment,
        quarterlyAccumulatedDepreciation as accumulated_depreciation,
        quarterlyOtherShortTermInvestments as other_short_term_investments,
        quarterlyTreasuryStock as treasury_stock,
        quarterlyTreasurySharesNumber as treasury_shares_number,
        quarterlyFinancialAssetsDesignatedasFairValueThroughProfitorLossTotal as financial_assets_designated_as_fair_value_through_profitor_loss_total,
        quarterlyDividendsPayable as dividends_payable,
        quarterlyRetainedEarnings as retained_earnings,
        quarterlyCommonStock as common_stock,
        quarterlyOrdinarySharesNumber as ordinary_shares_number,
        quarterlyWorkingCapital as working_capital,
        quarterlyAssetsHeldForSaleCurrent as assets_held_for_sale_current,
        quarterlyTaxesReceivable as taxes_receivable,
        quarterlyTotalLiabilitiesNetMinorityInterest as total_liabilities_net_minority_interest,
        quarterlyCashCashEquivalentsAndShortTermInvestments as cash_cash_equivalents_and_short_term_investments,
        quarterlyTotalAssets as total_assets,
        quarterlyInvestedCapital as invested_capital,
        quarterlyPayables as payables,
        quarterlyAccountsPayable as accounts_payable,
        quarterlyRestrictedCash as restricted_cash,
        quarterlyTotalEquityGrossMinorityInterest as total_equity_gross_minority_interest,
        quarterlyTotalNonCurrentAssets as total_non_current_assets,
        quarterlyGrossPPE as gross_ppe,
        quarterlyOtherReceivables as other_receivables,
        quarterlyNetTangibleAssets as net_tangible_assets,
        quarterlyReceivables as receivables,
        quarterlyLongTermDebt as long_term_debt,
        quarterlyTotalDebt as total_debt,
        quarterlyGoodwill as goodwill,
        quarterlyFinancialAssets as financial_assets,
        quarterlyAccountsReceivable as accounts_receivable,
        quarterlyPreferredStock as preferred_stock,
        quarterlyNetDebt as net_debt,
        quarterlyCashEquivalents as cash_equivalents,
        quarterlyCurrentDebt as current_debt

    from parsed_balance
),

final as (
    select * from rename_columns
)

select * from rename_columns