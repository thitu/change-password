# frozen_string_literal: true

source('https://rubygems.org')

git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.4'

gem 'bootsnap'
gem 'bootstrap'
gem 'dotenv-rails'
gem 'httparty'
gem 'jbuilder'
gem 'jquery-rails'
gem 'jwt'
gem 'puma'
gem 'rails'
gem 'sass-rails'
gem 'secure_headers'
gem 'trusona'
gem 'turbolinks'
gem 'tzinfo-data'

group :development, :test do
  gem 'brakeman'
  gem 'byebug'
  gem 'coveralls_reborn', require: false
  gem 'factory_bot'
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  gem 'rubocop'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
  gem 'simplecov', '0.21.2', require: false
end

group :development do
  gem 'guard'
  gem 'guard-rspec', require: false
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
