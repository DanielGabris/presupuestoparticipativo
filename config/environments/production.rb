CitizenBudget::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # Code is not reloaded between requests
  config.cache_classes = true

  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Disable Rails's static asset server (Apache or nginx will already do this)
  config.serve_static_assets = true

  # Compress JavaScripts and CSS
  config.assets.compress = true

  # Don't fallback to assets pipeline if a precompiled asset is missed
  config.assets.compile = false

  # Generate digests for assets URLs
  config.assets.digest = true

  # Defaults to Rails.root.join("public/assets")
  # config.assets.manifest = YOUR_PATH

  # Specifies the header that your server uses for sending files
  # config.action_dispatch.x_sendfile_header = "X-Sendfile" # for apache
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for nginx

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  # config.force_ssl = true

  # See everything in the log (default is :info)
  # config.log_level = :debug

  # Prepend all log lines with the following tags
  # config.log_tags = [ :subdomain, :uuid ]

  # Use a different logger for distributed setups
  # config.logger = ActiveSupport::TaggedLogging.new(SyslogLogger.new)

  # Use a different cache store in production
  # config.cache_store = :mem_cache_store
  config.cache_store = :dalli_store

  # Enable serving of images, stylesheets, and JavaScripts from an asset server
  # config.action_controller.asset_host = "http://assets.example.com"

  # Precompile additional assets (application.js, application.css, and all non-JS/CSS are already added)
  # @todo Shouldn't be necessary to add active_admin assets.
  config.assets.precompile += %w(
    active_admin.css
    active_admin.js
    active_admin/application.js
    active_admin/print.css
    individual/jquery.min.js
    individual/jquery-ui.min.js
    individual/jquery.validationEngine-en.js
    individual/jquery.validationEngine-es.js
    individual/jquery.validationEngine-fr.js
    individual/jquery.validationEngine-uk.js
    individual/modernizr.min.js
    simulators/default_simulator.js
    simulators/deviation_simulator.js
    simulators/impact_simulator.js
    simulators/tax_simulator.js
    print.css
  )

  # Disable delivery errors, bad email addresses will be ignored
  # config.action_mailer.raise_delivery_errors = false

  # Enable threaded mode
  # config.threadsafe!

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found)
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners
  config.active_support.deprecation = :notify

  config.action_mailer.default_url_options = {host: ENV['ACTION_MAILER_HOST']}

  # https://devcenter.heroku.com/articles/rack-cache-memcached-static-assets-rails31
  config.static_cache_control = 'public, max-age=2592000' # 30 days
  config.action_dispatch.rack_cache = {
    metastore: Dalli::Client.new,
    entitystore: 'file:tmp/cache/rack/body',
    allow_reload: false,
  }
end
