# frozen_string_literal: true
class Git
  def initialize
    @stashed = false
  end

  def supported?
    !status.include? 'not a git repository'
  end

  def clean?
    status.include? 'working directory clean'
  end

  def stash
    return unless supported? || clean?
    run 'stash -u'
    @stashed = true
    yield
  ensure
    run 'stash pop' if stashed?
    @stashed = false
  end

  def add(files)
    return unless clean?
    files.each { |f| run "add #{f}" }
  end

  private

  def stashed?
    @stashed
  end

  def status
    @status ||= run 'status'
  end

  def run(command)
    Dir.chdir ENV['BLOG_PATH'] { `git #{command}` }
  end
end
