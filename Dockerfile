FROM postgres:16-alpine

COPY ./scripts/dependencies.sql   /docker-entrypoint-initdb.d/00_dependencies.sql

# SCHEMAS
COPY ./scripts/schemas/accounts.sql   /docker-entrypoint-initdb.d/01_accounts.sql
COPY ./scripts/schemas/games.sql   /docker-entrypoint-initdb.d/02_games.sql

# RULESETS
COPY ./scripts/fill/srd5.sql   /docker-entrypoint-initdb.d/10_srd5.sql
