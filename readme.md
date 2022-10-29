# Yahoo finance warehouse

This is a repository for fetching, storing, modeling and analysing financial data from yahoo finance. The tools used are postgres for saving data, Airbyte for fetching data, dbt for modeling data and at some point Lightdash for visualizing data.

See [Warehouse setup](#warehouse-setup) below for a guide of how to go from no data to visualizing your sweet sweet data in Lightdash.

The project currently contains

* postgres database configuration in `database`
* airbyte source for yahoo finance financials in `source-yahoo-finance-financials`
* dbt project modeling yahoo finance stuff in `dbt-model`

Todo:

* add airbyte configuration files
* add lightdash metrics

## Warehouse setup

This section shows how to set up stuff on Linux. Most of the stuff runs in docker containers so it shouldn't be too different on other operating systems.

First we will setup the database Airbyte will load the data into and where dbt will do its modeling. Second we will set up Airbyte and make use of the custom source connector in this repository for fetching financial data. Third we will run the dbt code to go from raw data to money data. Then to finish it off we will visualize some of the data in Lightdash.

Let's get started!

### Prerequisites

It is assumed that you are familiar some stuff: mainly the terminal, but also some docker, python and sql. It doesn't hurt if you know some dbt.

### Database

Setting up the database should be quick.

Enter database folder

```sh
cd database
```

Start the container hosting the database

```sh
docker-compose up -d
```

Connect to the database somehow, e.g. through adminer at localhost:8080 in your web browser, and run the commands in `schemas.sql` and `users.sql`. The default login information is

* Server: db
* Username: postgres
* Password: postgres
* Database: postgres

If you're using adminer, click "SQL command" in the left menu to open a screen where you can run the commands.

Did the commands run successfully? If so, let's go to the next step of loading data with Airbyte!

### Fetch data with Airbyte

#### Airbyte setup

Step 1, clone the Airbyte repository (maybe it's enough to just copy their docker-compose.yml file?). Tips: clone it into a different folder than this repository.

```sh
git clone https://github.com/airbytehq/airbyte.git
```

Enter the airbyte repository folder and run

```sh
docker-compose up
```

Wait for some moments while everything starts up.

#### Add connector

Open up the Airbyte web client at localhost:8000.

Add the source-yahoo-finance-financials connector by clicking Settings (at the bottom left), Sources and + New connector. Fill in the form with the following text:

* Connector display name: Yahoo Finance Financials
* Docker repository name: travbula/source-yahoo-finance-financials
* Docker image tag: 0.1.30
* Connector Documentation URL: https://travbula.no

#### Add database destination

Click Destinations, + New destination, choose type Postgres. Suggested form text:

* Destination name: Warehouse
* Host: localhost
* Port: 5432
* DB Name: postgres
* Default Schema: raw_data
* User: airbyte_user
* Password: super_duper_secret

Click Set up destination

#### Add sources

Click Sources in the left menu.

First, add Yahoo Finance Financials:

* Source name: Yahoo Finance Financials
* tickers: AAPL MSFT ZOMD.V TSLA SDSD.OL

The tickers is a list, and the Airbyte UI seems to be a bit weird for lists. I have to tab out and back in again between each ticker. Note that the ticker must exist on Yahoo Finance! Look up your company on finance.yahoo.com and see what ticker they use. For example the company [S.D. Standard Etc Plc](https://finance.yahoo.com/quote/SDSD.OL?p=SDSD.OL&.tsrc=fin-srch) has the ticker SDSD.OL.

Click Set up source

Second, add Yahoo Finance Price:

* Source name: Yahoo Finance Price
* tickers: AAPL,MSFT,ZOMD.V,TSLA,SDSD.OL
* Interval: 1d
* Range: 5y

Note that the tickers is not a list in this form, but a comma-separated string.

Click Set up source

#### Add connections

Click Connections in the left menu.

First, connect Yahoo Finance Financials to the Warehouse. Click + New connection. Select an existing source: Yahoo Finance Financials. Click Use existing source. Select an existing destination: Warehouse. Click Use existing destination.

Suggested connection settings:

* Replication frequency: Manual
* Unclick Normalized tabular data at the bottom
* Leave everything else as is

Setup Yahoo Finance Price to Warehouse connection doing something similar.

#### Launch connections

Open the Connections menu and click Launch on both of the connections.

If the connections run successfully, Airbyte should have created some tables in the raw_data schema.

### Model data with dbt

#### Setup dbt

Open the dbt-model folder.

Create a python virtual environment.

```sh
python3 -m venv .venv
```

Activate environment.

```sh
source .venv/bin/activate
```

Install packages.

```sh
python -m pip install 
```

Check your connection.

```sh
dbt debug --profiles-dir=.
```

Tips: if you'd like to skip `--profiles-dir=.` each time, copy the `profiles.yml` file into `~/dbt/`.

Install dbt packages.

```sh
dbt deps
```

#### Run dbt

```sh
dbt run
```

If this was successful, your datawarehouse should have a bunch of views in the `analytics` schema. The most interesting views are those in the `dbt-model/models/marts/` folder:

* `dim_company`
* `dim_currency`
* `fact_balance_statement`
* `fact_free_cashflow`
* `fact_income_statement`
* `fact_stock_price`
* `latest_market_capitalization`
* `latest_stock_price_in_year`
* `market_capitalization`

See more information about these in the documentation generated in the next step.

#### Browse the documentation

Generate documentation of the dbt stuff

```sh
dbt docs generate
```

Start a web server that hosts the documentation

```sh
dbt docs serve --port 9000
```

Open the documentation in your web browser at localhost:9000.

### Visualize data with Lightdash

(WIP: Have not been able to get this to work yet)

Clone Lightdash repo and run their install script

```sh
git clone https://github.com/lightdash/lightdash
cd lightdash
./scripts/install.sh
```

For more help, see their [docs](https://docs.lightdash.com/get-started/setup-lightdash/install-lightdash/#deploy-locally-with-our-installation-script).

Open the Lightdash webclient at localhost:8080 and follow the instructions for setting up
