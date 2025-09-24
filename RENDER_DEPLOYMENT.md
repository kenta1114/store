# Render Deployment Configuration

## Build Command
bin/render-build.sh

## Start Command  
bundle exec puma -C config/puma.rb

## Environment Variables (set these in Render dashboard):

# Required:
- RAILS_MASTER_KEY: (copy from config/master.key)
- DATABASE_URL: (automatically provided by Render PostgreSQL)
- REDIS_URL: (if using Redis - automatically provided by Render Redis)

# Recommended:
- RAILS_LOG_TO_STDOUT: true
- RAILS_SERVE_STATIC_FILES: true
- RAILS_ENV: production

# For file uploads (if needed):
# - AWS_ACCESS_KEY_ID: your_aws_key
# - AWS_SECRET_ACCESS_KEY: your_aws_secret
# - AWS_REGION: your_aws_region
# - AWS_BUCKET: your_s3_bucket_name

## Services to create on Render:
1. PostgreSQL Database
2. Web Service (connected to GitHub repo)
3. Redis (if using caching/background jobs)

## Important Files:
- bin/render-build.sh (build script)
- Procfile (process definition)
- config/database.yml (PostgreSQL configuration)
- config/puma.rb (web server configuration)