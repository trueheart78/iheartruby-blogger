# frozen_string_literal: true
module Junklet
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
end
