-- dbt transforms schema
create schema analytics;

-- user for airbyte to insert data
CREATE USER airbyte_user PASSWORD 'super_duper_secret';
GRANT CREATE, TEMPORARY ON DATABASE postgres TO airbyte_user;

-- user for lightdash to select data
CREATE USER lightdash_user PASSWORD 'super_duper_secret';
GRANT CONNECT ON DATABASE postgres TO lightdash_user;
GRANT USAGE ON SCHEMA analytics TO lightdash_user;
GRANT SELECT ON ALL TABLES IN SCHEMA analytics TO lightdash_user;

ALTER DEFAULT PRIVILEGES IN SCHEMA analytics
GRANT SELECT ON TABLES TO lightdash_user;