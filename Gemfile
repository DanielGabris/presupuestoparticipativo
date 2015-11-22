source 'https://rubygems.org'
ruby '1.9.3'

gem 'rails', '3.2.22'
gem 'rails-i18n'

group :production do
  # Non-Heroku deployments
  unless ENV['HEROKU']
    gem 'foreman'
  end

  # Error logging
  gem 'airbrake', '~> 3.1.15'
  gem 'heroku'
  gem 'rails_12factor'

  # Performance
  gem 'action_dispatch-gz_static'
  gem 'memcachier'
  gem 'dalli'

  # Heroku deployments
  if ENV['HEROKU']
    gem 'newrelic_rpm'
  end
end

# Background jobs
gem 'girl_friday'

# Database
gem 'mongoid', '~> 3.1.0' # 4.0 is backwards-incompatible

# Admin
gem 'formtastic', '~> 2.2.1'
gem 'activeadmin', '0.6.3'
gem 'inherited_resources', '~> 1.4.1'
gem 'sass', '~> 3.2.14'
gem 'activeadmin-mongoid', '0.3.0'
gem 'cancan'
gem 'devise', '~> 2.1.3' # 2.2 is backwards-incompatible
gem 'devise-i18n'
gem 'google-api-client', '~> 0.6.4', require: 'google/api_client'
gem 'jwt', '~> 0.1.4' # google-api-client
gem 'mustache', '~> 0.99.0'

# Image uploads
gem 'fog'
gem 'rmagick'
gem 'carrierwave-mongoid', '~> 0.6.3'

# Views
gem 'haml-rails'
gem 'rdiscount'
gem 'unicode_utils'

# Export
gem 'spreadsheet'
gem 'axlsx', '2.0.0' # 2.0.1 uses rubyzip 1.0.0
gem 'rubyzip',  '~> 0.9.9' # 1.0.0 has new interface, heroku gem uses old interface https://github.com/rubyzip/rubyzip#important-note

# Heroku API
gem 'oj'
gem 'multi_json'
gem 'faraday'

# Rake
gem 'ruby-progressbar'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  # Non-Heroku deployments
  unless ENV['HEROKU']
    gem 'therubyracer', require: 'v8'
    gem 'libv8', '3.16.14.7'
  end

  gem 'sass-rails', '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# For maintenance scripts to run in development console.
group :development do
  gem 'mechanize'
  gem 'pry-rails'
  gem 'odf-report'
end

group :development, :test do
  gem 'rspec-rails', '~> 2.6'
end

gem 'unicorn'

group :development do
    gem 'capistrano',         require: false
    gem 'capistrano-rvm',     require: false
    gem 'capistrano-rails',   require: false
    gem 'capistrano-bundler', require: false
    gem 'capistrano3-puma',   require: false
end

gem 'puma'

