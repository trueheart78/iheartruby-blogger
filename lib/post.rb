# frozen_string_literal: true
require 'reason'
require 'date'

class Post
  attr_reader :title, :url

  class MissingBlogPathConfigError < StandardError; end

  def initialize(title, url = nil)
    @title = title
    @url = url.downcase if url
  end

  def exists?
    reason.exists?
  end

  def valid?
    return if title.nil? || title.empty?
    if url
      return unless url =~ %r{(http|https):\/\/}
    end
    true
  end

  def save
    return if exists? || !valid?
    File.write full_path, raw_content
  end

  def full_title
    "Reason ##{reason.number}: #{title.strip}"
  end

  def full_path
    raise MissingBlogPathConfigError unless ENV['BLOG_PATH']
    File.join ENV['BLOG_PATH'], '_posts', file_name
  end

  def content
    return title unless url
    "[#{title}](#{url})"
  end

  private

  def file_name
    "#{today} #{full_title}"
      .downcase.tr(' _', '-')
      .gsub(/[^0-9a-z-]/, '') << '.md'
  end

  def today
    Date.today.to_s
  end

  def reason
    @reason ||= Reason.new(title)
  end

  def raw_content
    [
      '---',
      'layout: post',
      "title: \"#{full_title}\"",
      "date: #{Time.now}",
      'categories: ruby',
      '---',
      '',
      content
    ].join "\n"
  end
end
