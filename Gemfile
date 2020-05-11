# frozen_string_literal: true

source('https://rubygems.org')

git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby('2.6.6')

gem('bootsnap')
gem('bootstrap')
gem('dotenv-rails')
gem('jbuilder')
gem('jquery-rails')
gem('puma')
gem('rails', '~> 6.0.2')
gem('sass-rails')
gem('trusona')
gem('turbolinks')
gem('tzinfo-data')

group :development, :test do
  gem 'brakeman'
  gem 'byebug'
  gem 'factory_bot'
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  gem 'rubocop'
  gem 'rubocop-performance'
  gem 'simplecov', require: false
  gem 'simplecov-json', require: false
end

group :development do
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen'
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'cucumber-rails', require: false
  gem 'launchy'
  gem 'rails-controller-testing'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
  gem 'webdrivers'
end
