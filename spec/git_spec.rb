# frozen_string_literal: true
require_relative 'spec_helper'
require 'git'
require 'tmpdir'

RSpec.describe Git do
  include_context 'iheartruby'

  before(:each) do
    save_env_vars blog_path: temp_dir
    ENV['GIT_DISCOVERY_ACROSS_FILESYSTEM'] = '1'
  end

  after(:each) do
    FileUtils.remove_entry temp_dir if Dir.exist? temp_dir
  end

  subject { described_class.new }

  it 'supports git' do
    initialize_git
    expect(subject).to be_supported
  end

  it 'cleans git' do
    initialize_git
    expect(subject).to be_clean
  end

  let(:temp_dir) { Dir.mktmpdir }

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
end
