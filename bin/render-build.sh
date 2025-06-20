#!/usr/bin/env bash
# exit on error
set -o errexit

echo "🔧 Starting Render build process..."

# Check if RAILS_MASTER_KEY is set
if [ -z "$RAILS_MASTER_KEY" ]; then
  echo "❌ ERROR: RAILS_MASTER_KEY environment variable is not set!"
  echo "Please configure RAILS_MASTER_KEY in your Render service environment variables."
  exit 1
fi

echo "✅ RAILS_MASTER_KEY is configured"

# Generate SECRET_KEY_BASE if not set (fallback for Render)
if [ -z "$SECRET_KEY_BASE" ]; then
  echo "🔄 Generating SECRET_KEY_BASE..."
  export SECRET_KEY_BASE=$(bundle exec rails runner "puts Rails.application.credentials.secret_key_base" 2>/dev/null || bundle exec rails secret)
  echo "✅ SECRET_KEY_BASE generated"
fi

# Install dependencies
echo "📦 Installing Ruby dependencies..."
bundle install

# Verify credentials work
echo "🔐 Verifying Rails credentials..."
bundle exec rails runner "puts 'Secret key configured: ' + (ENV['SECRET_KEY_BASE'].present? || Rails.application.credentials.secret_key_base.present?).to_s"

# Create databases if they don't exist (ignore errors)
echo "🗄️ Creating databases..."
bundle exec rails db:create || true

# Migrate databases
echo "🔄 Running database migrations..."
bundle exec rails db:migrate

# Migrate additional databases (cache, queue, cable) if they exist
echo "🔄 Running additional database migrations..."
bundle exec rails db:migrate:cache || echo "⚠️ Cache migrations not available"
bundle exec rails db:migrate:queue || echo "⚠️ Queue migrations not available" 
bundle exec rails db:migrate:cable || echo "⚠️ Cable migrations not available"

# Build assets
echo "🎨 Building assets..."
bundle exec rails assets:precompile
bundle exec rails assets:clean

echo "✅ Build completed successfully!"

# Seed database (opcional - descomenta si quieres ejecutar seeds)
# echo "🌱 Seeding database..."
# bundle exec rails db:seed
