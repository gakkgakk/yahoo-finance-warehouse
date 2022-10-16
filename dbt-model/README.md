# Readme

## Installation

### Python requirements

Create a virtual environment

`python3 -m venv .venv`

Activate environment

`. .venv/bin/activate`

Install requirements

`python -m pip install -r requirements.txt`

### Database configuration

Make sure your `profiles.yml` file is set up to match the database configuration of your warehouse. There is an example `profiles.yml` file in this project you can use with

`dbt debug --profiles-dir=.`

when you are in this folder. This should work with the configuration in `database/docker-compose.yml`, although you might have to create the `analytics` schema first.

### dbt dependencies

Install dbt dependencies

`dbt deps`
