#!/usr/bin/env bash
# exit on error
set -o errexit

# Install dependencies
bundle install

# Build assets
bundle exec rails assets:precompile
bundle exec rails assets:clean

# Migrate all databases (main, cache, queue, cable)
bundle exec rails db:migrate
bundle exec rails db:migrate:cache
bundle exec rails db:migrate:queue
bundle exec rails db:migrate:cable

# Create databases if they don't exist
bundle exec rails db:create || true

# Seed database (opcional - descomenta si quieres ejecutar seeds)
# bundle exec rails db:seed
