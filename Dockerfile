FROM postgres:16-alpine

COPY ./scripts/dependencies.sql   /docker-entrypoint-initdb.d/00_dependencies.sql
COPY ./scripts/01_run_subdirs.sh   /docker-entrypoint-initdb.d/

# SCHEMAS
COPY ./scripts/0_schemas /docker-entrypoint-initdb.d/
# COPY ./scripts/schemas/accounts.sql   /docker-entrypoint-initdb.d/01_accounts.sql
# COPY ./scripts/schemas/games.sql   /docker-entrypoint-initdb.d/02_games.sql

# RULESETS
COPY ./scripts/1_fill /docker-entrypoint-initdb.d/
# COPY ./scripts/fill/srd5_poc.sql   /docker-entrypoint-initdb.d/10_srd5.sql
