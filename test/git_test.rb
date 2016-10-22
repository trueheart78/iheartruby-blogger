# frozen_string_literal: true
require_relative 'test_helper'
require 'git'
require 'tmpdir'

class GitTest < IHeartTest
  def subject
    @subject ||= Git.new valid_post
  end

  def temp_dir
    @temp_dir ||= Dir.mktmpdir
  end

  def test_supports_git
    initialize_git
    assert subject.supported?
  end

  def test_clean
    initialize_git
    assert subject.clean?
  end

  def setup
    super
    save_env_vars blog_path: temp_dir
    ENV['GIT_DISCOVERY_ACROSS_FILESYSTEM'] = '1'
  end

  def teardown
    FileUtils.remove_entry @temp_dir if Dir.exist? @temp_dir
    super
  end

  def initialize_git(state: :clean)
    Dir.chdir temp_dir do
      system 'git', 'init'
      File.write junk, junk
      if state == :clean
        system 'git', 'add', '.'
        system 'git', 'commit', '-m', junk
      end
    end
  end

  def commit_changes
  end

  def valid_post
    @valid_post ||= Post.new junk_title, junk_url(:https)
  end

  def invalid_post
    @invalid_post ||= Post.new nil
  end
end
