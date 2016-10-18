# frozen_string_literal: true
ENV['NODE_ENV'] = 'test'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '../lib'))

require 'minitest/autorun'
