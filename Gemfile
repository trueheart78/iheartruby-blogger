# frozen_string_literal: true
source 'https://rubygems.org'
ruby '2.3.1' # keep .ruby-version in sync with this

gem 'rake'
gem 'dotenv'

group :development do
  gem 'guard'
  gem 'guard-minitest'
end

group :test, :development do
  gem 'minitest'
  gem 'byebug'
  gem 'rubocop', require: false
end
