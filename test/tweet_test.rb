# frozen_string_literal: true
require_relative 'test_helper'
require 'tweet'

class TweetTest < Minitest::Test
  TestPost = Struct.new :full_title, :url

  def test_sample
    Tweet.update 'post'
  end

  def post
    TestPost.new 'sample', 'http://www.example.com'
  end
end
