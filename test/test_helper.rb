# frozen_string_literal: true
ENV['NODE_ENV'] = 'test'

require 'bundler'
Bundler.require
Dotenv.load

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '../lib'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'support'))

require 'minitest/autorun'
require 'webmock/minitest'
require 'securerandom'
require 'faker'
require 'byebug'
require 'junklet'
require 'ihearttest'
