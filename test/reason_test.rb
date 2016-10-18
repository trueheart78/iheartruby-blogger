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
    assert_equal([1, 'something'], Reason.find('Something'))
    assert_equal([2, 'something else'], Reason.find('Something Else'))
    assert_equal([3, 'something more'], Reason.find('Something More'))
    refute(Reason.find('something wrong'))
  end

  def test_exists
    refute(Reason.new(junk).exists?)
    assert(Reason.new('Something').exists?)
  end

  def test_save
    File.stub :write, true do
      refute(Reason.new('Something').save)
      assert(Reason.new(junk).save)
    end
  end

  def test_save_then_exist
    File.stub :write, true do
      reason = Reason.new junk
      refute(Reason.find(reason.title))
      refute(reason.exists?)
      assert(reason.save)
    end
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
