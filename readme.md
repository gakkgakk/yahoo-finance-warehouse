# Yahoo finance warehouse

This is a repository for fetching, storing, modeling and analysing financial data from yahoo finance. The tools used are postgres for saving data, airbyte for fetching data and dbt for modeling data.

The project currently contains

* postgres database configuration in `database`
* airbyte source for yahoo finance financials in `source-yahoo-finance-financials`
* dbt project modeling yahoo finance stuff in `dbt-model`

Todo:

* add airbyte configuration files
* add lightdash metrics
