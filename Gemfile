source 'https://rubygems.org'

ruby '2.0.0'

gem 'rails', '3.2.13'
gem 'chosen-rails'

group :production do
  gem 'pg', '0.13.2'
  gem 'thin'
  gem 'rollbar'
  gem 'rails_12factor'
end

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

group :development do
  gem "better_errors"
  gem 'letter_opener'
  gem 'quiet_assets'
end
group :development, :test do
  gem 'rspec-rails'
  gem 'spring'
  gem "factory_girl_rails"
  gem 'sqlite3'
  gem "email_spec"
  gem "selenium-webdriver"
  gem "binding_of_caller"
end

group :test do
  gem 'rb-fsevent', '~> 0.9.1'
  gem "faker", "~> 1.0.1"
  gem "launchy"
  gem 'capybara'
  gem "database_cleaner", "~> 0.7.2"
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'jquery-ui-sass-rails'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem "recaptcha", :require => "recaptcha/rails"
gem 'jquery-rails'
gem 'devise'
gem 'haml-rails'
gem 'mini_magick'
gem 'cancan'
gem 'nested_form'
gem 'truncate_html'
gem 'rinku', '~> 1.7', :require => 'rails_rinku'
gem 'paper_trail'
gem 'diffy'
gem 'carrierwave'
gem "fog", "~> 1.3.1"
gem "ancestry"
gem 'kaminari'
gem 'stringex'
# gem "omniauth-facebook"
gem 'cartodb-rb-client', github: 'Vizzuality/cartodb-rb-client'
gem 'leaflet-rails'
gem "font-awesome-rails"
gem 'pg_search'
gem 'impressionist'
gem 'sitemap_generator'
#gem 'gibbon'
gem 'heroku_rails_deflate', :group => :production

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
