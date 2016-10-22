# frozen_string_literal: true
require_relative 'test_helper'
require 'post'

class PostTest < Minitest::Test
  include TestHelper

  def test_exists
    assert(Post.new('something').exists?)
    refute(Post.new(junk_title).exists?)
  end

  def test_attr_methods
    title = junk_title
    assert_equal(title, Post.new(title).title)
    assert_equal(nil, Post.new(title).url)
    url = junk
    assert_equal(url, Post.new(title, url).url)
  end

  def test_valid
    assert Post.new(junk_title).valid?
    assert Post.new(junk_title, junk_url).valid?
    assert Post.new(junk_title, junk_url(:https)).valid?

    refute Post.new(nil).valid?
    refute Post.new('').valid?
    refute Post.new(junk_title, 'www.xyz.com').valid?
    refute Post.new(junk_title, 'ftp://butts.com').valid?
  end

  def test_full_title
    post = Post.new junk_title
    assert_equal("Reason #4: #{post.title}", post.full_title)
  end

  def test_full_path
    post = Post.new junk_title
    assert(post.full_path.start_with?(post_path))
    assert(post.full_path.end_with?('.md'))
  end

  def test_content
    title = junk_title
    assert_equal(title, Post.new(title).content)

    url = junk_url
    content = "[#{title}](#{url})"
    assert_equal(content, Post.new(title, url).content)
  end

  def test_save
    post = Post.new junk_title
    mock = mock_file_save post
    File.stub(:write, mock) do
      refute(post.exists?)
      assert(post.save)
    end
  end

  def test_save_with_url
    post = Post.new junk_title, junk_url
    mock = mock_file_save post
    File.stub(:write, mock) do
      refute(post.exists?)
      assert(post.save)
    end
  end

  def test_save_when_invalid
    post = Post.new ''
    refute(post.valid?)
    refute(post.save)
  end

  def test_save_when_exists
    post = Post.new 'Something'
    assert(post.exists?)
    refute(post.save)
  end

  def mock_file_save(post)
    lambda do |file, content|
      assert_equal(post.full_path, file)

      assert_match(/layout:\spost/, content)
      assert_match(/title:\s\"#{post.full_title}\"/, content)
      assert_match(/categories:\sruby/, content)

      assert(content.end_with? post.content)
    end
  end
end
