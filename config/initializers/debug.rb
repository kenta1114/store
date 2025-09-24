# Conditionally require debug/prelude only in development and test environments
# and only if DISABLE_DEBUG is not set
if (Rails.env.development? || Rails.env.test?) && !ENV['DISABLE_DEBUG']
  begin
    require "debug/prelude"
  rescue LoadError
    # Debug gem not available, continue without it
  end
end