require 'twitter'

class Tweet
  class << self
    def update(post)
      connection.update compose(post)
    end

    def connected?
      required_keys.all? { |k| ENV.fetch(k, 'unailable') != 'unavailable' }
    end

    def required_keys
      [
        'TWITTER_CONSUMER_KEY',
        'TWITTER_CONSUMER_SECRET',
        'TWITTER_ACCESS_TOKEN',
        'TWITTER_ACCESS_TOKEN_SECRET'
      ]
    end

    private

    def compose(post)
      content = post.full_title.strip
      content.concat " #{post.url.strip}" if post.url
    end

    def connection
      Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
        config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
        config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
        config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
      end
    end
  end
end
