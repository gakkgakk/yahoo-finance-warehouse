-- user for airbyte to insert data
CREATE USER airbyte_user PASSWORD 'super_duper_secret';
GRANT CREATE, TEMPORARY ON DATABASE postgres TO airbyte_user;