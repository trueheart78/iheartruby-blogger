# frozen_string_literal: true
ENV['NODE_ENV'] = 'test'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '../lib'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'support'))

require 'minitest/autorun'
require 'securerandom'
require 'faker'
require 'byebug'
require 'junklet'
require 'ihearttest'
