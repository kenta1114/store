#!/usr/bin/env bash
# Render build script with error handling

set -o errexit  # Exit on error

echo "Starting Render build process..."

# Install dependencies
echo "Installing Ruby gems..."
bundle config --local deployment 'true'
bundle config --local path './vendor/bundle'
bundle install --without development test

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