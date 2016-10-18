# frozen_string_literal: true
require 'reason'
require 'date'

class Post
  attr_reader :title, :url

  class MissingBlogPathConfigError < StandardError; end

  def initialize(title, url = nil)
    @title = title
    @url = url
  end

  def exists?
    reason.exists?
  end

  def save
    return if exists?
    File.write 'path.md', content
  end

  private

  def full_title
    "Reason ##{reason.number}: #{title.strip}"
  end

  def full_path
    raise MissingBlogPathConfigError unless ENV['BLOG_PATH']
    File.join ENV['BLOG_PATH'], '_posts', file_name
  end

  def file_name
    full_title.downcase.tr(" '-", '_').tr('~()?!:#', '') << '.md'
  end

  def reason
    @reason ||= Reason.new(title)
  end

  def raw_content
    [
      '---',
      'layout: post',
      "title: \"#{title}\"",
      "date: #{Time.now}",
      'categories: ruby',
      '---',
      '',
      content
    ].join "\n"
  end

  def content
    return "[#{title}](#{url})" if url
    title
  end
end
