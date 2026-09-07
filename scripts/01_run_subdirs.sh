#!/bin/bash
set -e

# Find and execute all .sql files in subdirectories recursively, sorted alphabetically
find /docker-entrypoint-initdb.d -mindepth 2 -type f -name "*.sql" | sort | while read -r file; do
    echo "Executing $file..."
    psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" -f "$file"
done
