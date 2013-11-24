source 'https://rubygems.org'
ruby '2.0.0'
#ruby-gemset=rails_4_0_1

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.1'

group :development, :test do
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'

  gem 'rspec-rails'
  gem 'guard-rspec'
  gem 'growl'
  gem 'spork-rails'
  gem 'guard-spork'
  gem 'childprocess'
end

group :development do
  gem 'guard-livereload', require: false
  gem 'rack-livereload'
  gem "rails_best_practices"

  # Use capistrano for deployment
  gem 'capistrano'
  gem 'capistrano-rvm', github: "capistrano/rvm"
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
end

group :test do
	gem 'selenium-webdriver'
	gem 'capybara'
  gem 'simplecov', require: false
  gem 'factory_girl_rails'
end

# Use device for account management
gem 'devise'

# Pagenate
gem 'will_paginate'
gem 'will_paginate-bootstrap'

# Use bootstrap
gem 'anjlab-bootstrap-rails', :require => 'bootstrap-rails',
                              :github => 'anjlab/bootstrap-rails',
                              :branch => '3.0.0'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

# Use faker for generating email addresses
gem 'faker'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

group :production do
  gem 'mysql2'
end
