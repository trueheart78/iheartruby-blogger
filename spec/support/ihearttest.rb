# frozen_string_literal: true
RSpec.shared_context 'iheartruby' do
  include Junklet

  before(:each) do
    cache_env_vars
    save_env_vars yaml_file: 'reasons.yaml',
      blog_path: fixture_path
  end

  after(:each) do
    restore_env_vars
  end

  def fixture_path(path = '')
    File.join Dir.pwd, 'test/fixtures', path
  end

  def save_env_vars(blog_path: fixture_path, yaml_file: nil)
    ENV['BLOG_PATH'] = blog_path if blog_path
    ENV['YAML_PATH'] = File.join(ENV['BLOG_PATH'], yaml_file) if yaml_file
  end

  def cache_env_vars
    yaml_file = ENV['YAML_PATH'] if ENV.include?('YAML_PATH')
    blog_path = ENV['BLOG_PATH'] if ENV.include?('BLOG_PATH')
  end

  def remove_yaml_path
    ENV.delete 'YAML_PATH'
  end

  def restore_env_vars
    ENV['YAML_PATH'] = yaml_file if yaml_file
    ENV['BLOG_PATH'] = blog_path if blog_path
  end

  let(:yaml_file) { nil }
  let(:blog_path) { ENV['BLOG_PATH'] }
  let(:posts_path) { File.join blog_path, '_posts' }
  let(:post_path) { posts_path }


  def capture_output
    foo = StringIO.new
    old_stdout = $stdout
    $stdout = foo
    yield
    $stdout.string
  ensure
    $stdout = old_stdout
  end
  alias suppress_output capture_output
end
