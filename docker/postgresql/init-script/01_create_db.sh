#!/bin/sh
set -e

psql -v ON_ERROR_STOP=1 --username "${POSTGRES_USER}" --dbname "${POSTGRES_DB}" <<-EOSQL
    CREATE USER "${APP_DATABASE_USER}" WITH PASSWORD '${APP_DATABASE_PASSWORD}' CREATEDB;

    CREATE DATABASE "${APP_DATABASE_NAME}" OWNER "${APP_DATABASE_USER}";
    GRANT ALL PRIVILEGES ON DATABASE "${APP_DATABASE_NAME}" TO "${APP_DATABASE_USER}";

    CREATE TABLE users (id text, name text, email text, password text);
EOSQL