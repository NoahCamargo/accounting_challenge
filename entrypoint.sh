#!/bin/bash
set -e

echo "> Migrating Database"
bundle exec rake db:migrate

echo "> Populating Database"
bundle exec rails db:seed

# Remove a potentially pre-existing server.pid for Rails.
rm -f /accounting_challenge/tmp/pids/server.pid

bundle exec rake cache:fetch

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"