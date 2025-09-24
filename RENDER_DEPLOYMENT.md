# Render Deployment Configuration

## Build Command
```
./bin/render-build.sh
```

## Start Command  
```
bundle exec puma -C config/puma.rb -p $PORT
```

## Environment Variables (set these in Render dashboard):

### Required:
- `RAILS_MASTER_KEY`: (copy from config/master.key)
- `DATABASE_URL`: (automatically provided by Render PostgreSQL)

### Recommended:
- `RAILS_LOG_TO_STDOUT`: true
- `RAILS_SERVE_STATIC_FILES`: true
- `RAILS_ENV`: production
- `BUNDLE_WITHOUT`: development:test

### For file uploads (if needed):
- `AWS_ACCESS_KEY_ID`: your_aws_key
- `AWS_SECRET_ACCESS_KEY`: your_aws_secret
- `AWS_REGION`: your_aws_region
- `AWS_BUCKET`: your_s3_bucket_name

## Services to create on Render:
1. PostgreSQL Database
2. Web Service (connected to GitHub repo)
3. Redis (if using caching/background jobs)

## Troubleshooting Common Errors:

### Bundle Install Error (exit code 16)
**Error**: `process "/bin/sh -c bundle install" did not complete successfully: exit code: 16`

**Solutions**:
1. Ensure `.ruby-version` file specifies Ruby 3.3.0
2. Use the improved build script with proper bundle configuration
3. Set `BUNDLE_WITHOUT=development:test` environment variable
4. Make sure `pg` gem is in production group only

### Memory Issues
- Render free tier has 512MB RAM limit
- Reduce Puma workers/threads if needed
- Consider upgrading to paid plan for more memory

### Asset Compilation Issues
- Make sure Tailwind CSS builds correctly in production
- Check that `rails assets:precompile` includes Tailwind build step
- Verify all asset dependencies are available

### Database Connection Issues
- Ensure DATABASE_URL is properly set by Render
- Check database service is running and connected
- Verify migrations run successfully during build

## Important Files:

- bin/render-build.sh (build script)
- Procfile (process definition)
- config/database.yml (PostgreSQL configuration)
- config/puma.rb (web server configuration)
