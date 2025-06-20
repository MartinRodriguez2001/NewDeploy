#!/usr/bin/env bash
# exit on error
set -o errexit

# Install dependencies
bundle install

# Build assets
bundle exec rails assets:precompile
bundle exec rails assets:clean

# Migrate database
bundle exec rails db:migrate

# Seed database (opcional - descomenta si quieres ejecutar seeds)
# bundle exec rails db:seed
