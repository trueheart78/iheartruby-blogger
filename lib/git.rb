# frozen_string_literal: true
require 'post'

class Git
  class DirtyGitError < StandardError; end

  def initialize(post)
    @post = post
  end

  def supported?
    !status.include? 'not a git repository'
  end

  def clean?
    status.include? 'working directory clean'
  end

  private

  def status
    return @status if @status
    Dir.chdir ENV['BLOG_PATH'] do
      @status = `git status`
    end
  end
end
