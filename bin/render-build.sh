#!/usr/bin/env bash
# exit on error
set -o errexit

# Install dependencies
bundle install

# Build assets
bundle exec rails assets:precompile
bundle exec rails assets:clean

# Create databases if they don't exist (ignore errors)
bundle exec rails db:create || true

# Migrate databases
bundle exec rails db:migrate

# Migrate additional databases (cache, queue, cable) if they exist
bundle exec rails db:migrate:cache || true
bundle exec rails db:migrate:queue || true
bundle exec rails db:migrate:cable || true

# Seed database (opcional - descomenta si quieres ejecutar seeds)
# bundle exec rails db:seed
