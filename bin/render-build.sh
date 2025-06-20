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

# Generate SECRET_KEY_BASE if not set
if [ -z "$SECRET_KEY_BASE" ]; then
  echo "🔄 Generating SECRET_KEY_BASE from RAILS_MASTER_KEY..."
  # Use a deterministic method to generate SECRET_KEY_BASE from RAILS_MASTER_KEY
  export SECRET_KEY_BASE=$(echo -n "$RAILS_MASTER_KEY" | sha256sum | cut -d' ' -f1)
  echo "✅ SECRET_KEY_BASE generated: ${SECRET_KEY_BASE:0:20}..."
fi

# Install dependencies
echo "📦 Installing Ruby dependencies..."
bundle install

# Verify Rails configuration
echo "🔐 Verifying Rails configuration..."
bundle exec rails runner "puts 'Rails environment: ' + Rails.env; puts 'Secret key configured: ' + Rails.application.config.secret_key_base.present?.to_s"

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
