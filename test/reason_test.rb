# frozen_string_literal: true
require_relative 'test_helper'
require 'reason'

class ReasonTest < Minitest::Test
  def test_unset_env_yaml_path
    remove_yaml_path
    assert_raises Reason::MissingYamlPathConfigError do
      Reason.yaml_path
    end
  end

  def test_missing_yaml_file
    save_yaml_path File.expand_path("~/#{junk}.yaml")
    assert_equal({}, Reason.all)
    assert_equal(0, Reason.count)
  end

  def test_existing_yaml_file
    assert(Reason.all.include?(:something))
    assert(Reason.all.include?(:something_else))
    assert(Reason.all.include?(:something_more))
    assert_equal(3, Reason.count)
  end

  def test_find
    assert(Reason.find('something else'))
    refute(Reason.find('something wrong'))
  end

  def setup
    cache_yaml_path
    save_yaml_path fixture_path('reasons.yaml')
  end

  def teardown
    restore_yaml_path
  end

  def save_yaml_path(path)
    ENV['YAML_PATH'] = path
  end

  def cache_yaml_path
    return unless ENV.include? 'YAML_PATH'
    @yaml_path = ENV['YAML_PATH']
  end

  def remove_yaml_path
    ENV.delete 'YAML_PATH'
  end

  def restore_yaml_path
    return unless @yaml_path
    ENV['YAML_PATH'] = @yaml_path
  end
end
