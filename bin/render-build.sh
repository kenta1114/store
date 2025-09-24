#!/usr/bin/env bash
# Render build script with error handling

set -o errexit  # Exit on error

echo "Starting Render build process..."

# Set environment variables for production
export DISABLE_DEBUG=1
export RAILS_ENV=production

# Generate a secret key if not provided
if [ -z "$SECRET_KEY_BASE" ]; then
  export SECRET_KEY_BASE=$(openssl rand -hex 64)
  echo "Generated SECRET_KEY_BASE for build process"
fi

# Install Ruby gems
echo "Installing Ruby gems..."
bundle config set --local deployment 'true'
bundle config set --local without 'development test'
bundle install

# Clean up bundle cache
echo "Cleaning bundle cache..."
bundle clean --force
rm -rf vendor/bundle/ruby/*/cache vendor/bundle/ruby/*/bundler/gems/*/.git

# Precompile assets (including Tailwind CSS)
echo "Precompiling assets..."
bundle exec rails tailwindcss:build
bundle exec rails assets:precompile

# Run database migrations
echo "Running database migrations..."
bundle exec rails db:migrate

echo "Build process completed successfully!"