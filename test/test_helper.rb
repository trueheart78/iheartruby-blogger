# frozen_string_literal: true
ENV['NODE_ENV'] = 'test'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '../lib'))

require 'minitest/autorun'
require 'securerandom'
require 'faker'
require 'byebug'

module TestHelper
  def junk
    SecureRandom.uuid
  end

  def junk_title
    Faker::Lorem.sentence
  end

  def junk_url(format = :http)
    return Faker::Internet.url.gsub('http:', 'https:') if format == :https
    Faker::Internet.url
  end

  def fixture_path(path = '')
    File.join Dir.pwd, 'test/fixtures', path
  end

  def setup
    cache_env_vars
    save_env_vars yaml_file: 'reasons.yaml',
                  blog_path: fixture_path
  end

  def teardown
    restore_env_vars
  end

  def save_env_vars(blog_path: fixture_path, yaml_file: nil)
    ENV['BLOG_PATH'] = blog_path if blog_path
    ENV['YAML_PATH'] = File.join(ENV['BLOG_PATH'], yaml_file) if yaml_file
  end

  def cache_env_vars
    @yaml_file = ENV['YAML_PATH'] if ENV.include?('YAML_PATH')
    @blog_path = ENV['BLOG_PATH'] if ENV.include?('BLOG_PATH')
  end

  def remove_yaml_path
    ENV.delete 'YAML_PATH'
  end

  def restore_env_vars
    ENV['YAML_PATH'] = @yaml_file if @yaml_file
    ENV['BLOG_PATH'] = @blog_path if @blog_path
  end

  def blog_path
    ENV['BLOG_PATH']
  end

  def posts_path
    File.join blog_path, '_posts'
  end
  alias post_path posts_path
end
