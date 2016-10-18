# frozen_string_literal: true
require_relative 'test_helper'
require 'post'

class PostTest < Minitest::Test
  include TestHelper

  def test_exists
    assert(Post.new('something').exists?)
    refute(Post.new(junk).exists?)
  end

  def test_attr_methods
    title = junk
    assert_equal(title, Post.new(title).title)
    assert_equal(nil, Post.new(title).url)
    url = junk
    assert_equal(url, Post.new(title, url).url)
  end

  def test_save
    File.stub :write, true do
      post = Post.new junk
      refute(post.exists?)
      assert(post.save)
    end
  end

  def test_save_when_exists
    post = Post.new 'Something'
    assert(post.exists?)
    refute(post.save)
  end
end
