# frozen_string_literal: true
source 'https://rubygems.org'
ruby '2.3.1' # keep .ruby-version in sync with this

gem 'rake'
gem 'dotenv'
gem 'twitter'

group :development do
  gem 'guard'
  gem 'guard-minitest'
  gem 'guard-rspec'
end

group :test, :development do
  gem 'minitest'
  gem 'rspec'
  gem 'rspec-junklet'
  gem 'byebug'
  gem 'faker'
  gem 'rubocop', require: false
end
