source "https://rubygems.org"

gem 'rails', '4.2.4'

## Assets
gem 'sass-rails', '~> 5.0.3'
gem 'coffee-rails', '~> 4.1.0'
gem 'uglifier', '~> 2.7.1'
gem 'bootstrap-on-rails', '3.3.1'
gem 'font-awesome-rails', '~> 4.4.0'
gem 'less-rails', '~> 2.7.0'
gem 'therubyracer', '~> 0.12.2'

## Frontend / Views
gem 'jquery-rails', '~> 4.0.5'
gem 'redcarpet', '~> 3.3.3'
gem 'simple_form', '~> 3.2.0'
gem 'cocoon', '~> 1.2.6'
gem 'active_model_serializers', '~> 0.8.3'

## Backbone
gem 'ejs', '~> 1.1.1'
gem 'eco', '~> 1.0.0'

## Mongo DB
gem 'mongoid', '~> 4.0.2'
gem 'mongoid-slug', '~> 4.0.0'
gem 'geocoder', '~> 1.2.11' #https://github.com/alexreisner/geocoder/issues/832
gem 'mongoid_scribe', '~> 0.3.0'

## Authentication
gem 'omniauth', '~> 1.2.1'
gem 'omniauth-facebook', '~> 2.0.0'
gem 'bcrypt', '~> 3.1.10'

## Operations
gem 'passenger', '5.0.13'
gem 'exception_notification', '~> 4.1.1', group: [:production]

group :development do
  gem 'capistrano', '~> 3.4.0', require: false
  gem 'capistrano-rails', '~> 1.1.3', require: false
  gem 'capistrano-bundler', '~> 1.1.1', require: false
  gem 'capistrano-passenger', '~> 0.1.1', require: false
end

group :development, :test do
  gem 'rspec-rails', '~> 3.3.3'
  gem 'factory_girl_rails', '~> 4.5.0'
  gem 'database_cleaner', '~> 1.4.0'
  gem 'byebug', '~> 6.0.2'
  gem 'faker', '~> 1.5.0'
  gem 'teaspoon-jasmine', '~> 2.2.0'
  gem 'pry-rails', '~> 0.3.4'
end
