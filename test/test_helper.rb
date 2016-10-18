# frozen_string_literal: true
ENV['NODE_ENV'] = 'test'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '../lib'))

require 'minitest/autorun'
require 'securerandom'
require 'byebug'

def junk
  SecureRandom.uuid
end

def fixture_path(path)
  File.join Dir.pwd, 'test/fixtures', path
end
