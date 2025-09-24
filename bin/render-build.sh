#!/usr/bin/env bash
# build.sh

# Install dependencies
bundle install

# Precompile assets (including Tailwind CSS)
bundle exec rails assets:precompile

# Run database migrations
bundle exec rails db:migrate

# Seed the database if needed (optional - remove if not needed in production)
# bundle exec rails db:seed