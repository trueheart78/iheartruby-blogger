# frozen_string_literal: true
require_relative 'test_helper'
require 'reason'

class ReasonTest < IHeartTest
  def test_unset_env_yaml_path
    remove_yaml_path
    assert_raises Reason::MissingYamlPathConfigError do
      Reason.yaml_path
    end
  end

  def test_missing_yaml_file
    save_env_vars yaml_file: "#{junk}.yaml"
    assert_equal({}, Reason.all)
    assert_equal(0, Reason.count)
  end

  def test_existing_yaml_file
    assert(Reason.all.include?(:something))
    assert(Reason.all.include?(:something_else))
    assert(Reason.all.include?(:something_more))
  end

  def test_count
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

  def test_number
    assert_equal(1, Reason.new('Something').number)
    assert_equal(4, Reason.new(junk).number)
  end

  def test_save_then_exist
    File.stub :write, true do
      reason = Reason.new junk
      refute(Reason.find(reason.title))
      refute(reason.exists?)
      assert(reason.save)
      Reason.stub :find, [1, reason.title] do
        assert(reason.exists?)
      end
    end
  end
end
