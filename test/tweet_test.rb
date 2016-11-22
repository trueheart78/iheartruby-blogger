# frozen_string_literal: true
require_relative 'test_helper'
require 'tweet'

class TweetTest < Minitest::Test
  TestPost = Struct.new :full_title, :url

  def setup
    stub_twitter_auth
    stub_twitter_update
  end

  def test_connected
    assert Tweet.connected?
  end

  def test_not_connected
    env_backup
    Tweet.required_keys.each do |key|
      ENV.delete key
      refute Tweet.connected?
      env_restore
    end
  ensure
    env_restore
  end

  def test_post
    Tweet.update post
  end

  def test_post_with_url
    Tweet.update post_with_url
  end

  def env_backup
    @env = {}
    Tweet.required_keys.each do |key|
      @env[key] = ENV.fetch key, 'unavailable'
    end
  end

  def env_restore
    return if @env.empty?
    Tweet.required_keys.each do |key|
      ENV[key] = @env.fetch key, 'unavailable'
    end
  end

  def post
    TestPost.new 'sample'
  end

  def post_with_url
    TestPost.new 'sample', 'http://www.example.com'
  end

  def long_post
    TestPost.new('a' * 141)
  end

  def stub_tweet
    Twitter::REST::Client.stub :new, true do
      yield
    end
  end

  def stub_twitter_update
    stub_request(:post, "https://api.twitter.com/1.1/statuses/update.json").
      with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/x-www-form-urlencoded'}).
      to_return(:status => 200)
  end

  def stub_twitter_auth
    stub_request(:post, "https://api.twitter.com/oauth2/token").
      with(:body => "grant_type=client_credentials",
           :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/x-www-form-urlencoded; charset=UTF-8'}).
			to_return(:status => 200)
	end
end
