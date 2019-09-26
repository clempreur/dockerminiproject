#!/bin/bash
# Docker entrypoint script.

# Wait until Postgres is ready
while ! pg_isready -q -h $PGHOST -p $PGPORT -U $PGUSER
do
  echo "$(date) - waiting for database to start"
  sleep 2
done
mix local.rebar --force
mix ecto.drop
mix ecto.create
mix ecto.migrate


exec mix phx.server
