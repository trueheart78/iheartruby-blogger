# frozen_string_literal: true
require_relative 'spec_helper'
require 'post'

RSpec.describe Post do
  include_context 'iheartruby'

  describe '#exists?' do
    context 'when a duplicate post is passed in' do
      it 'returns true' do
        expect(Post.new('something')).to be_exists
      end
    end
    context 'when a unique post is passed in' do
      it 'returns false' do
        expect(Post.new(junk_title)).to_not be_exists
      end
    end
  end

  describe '#title' do
    subject { described_class.new title }

    context 'when passed in' do
      it 'matches what was passed in' do
        expect(subject.title).to eq title
      end

      let(:title) { junk_title }
    end
  end

  describe '#url' do
    subject { described_class.new title, url }

    context 'when passed in' do
      it 'matches what was passed in' do
        expect(subject.url).to eq url
      end

      let(:url)   { junk }
    end

    let(:title) { junk_title }
  end

  describe '#valid?' do
    subject { described_class.new title, url }

    context 'when passed a title and basic url' do
      it 'returns true' do
        expect(subject).to be_valid
      end

      let(:url)   { junk_url :http }
    end

    context 'when passed a title and secure url' do
      it 'returns true' do
        expect(subject).to be_valid
      end

      let(:url)   { junk_url :https }
    end

    context 'when passed a title and a non-http url' do

      it 'returns false' do
        expect(subject).to_not be_valid
      end

      let(:url) { "ftp://#{junk}" }
    end

    context 'when passed a title only' do
      it 'returns true' do
        expect(subject).to be_valid
      end

      let(:url) { nil }
    end

    context 'when passed an empty title' do
      it 'returns false' do
        expect(subject).to_not be_valid
      end

      let(:title) { '' }
    end

    context 'when passed a nil title' do
      it 'returns false' do
        expect(subject).to_not be_valid
      end

      let(:title) { nil }
    end

    let(:title) { junk_title }
    let(:url)   { nil }
  end

  #  def test_full_title
  #    post = Post.new junk_title
  #    assert_equal("Reason #4: #{post.title}", post.full_title)
  #  end
  #
  #  def test_full_path
  #    post = Post.new junk_title
  #    assert(post.full_path.start_with?(post_path))
  #    assert(post.full_path.end_with?('.md'))
  #  end
  #
  #  def test_content
  #    title = junk_title
  #    assert_equal(title, Post.new(title).content)
  #
  #    url = junk_url
  #    content = "[#{title}](#{url})"
  #    assert_equal(content, Post.new(title, url).content)
  #  end
  #
  #  def test_save
  #    post = Post.new junk_title
  #    mock = mock_file_save post
  #    File.stub(:write, mock) do
  #      refute(post.exists?)
  #      assert(post.save)
  #    end
  #  end
  #
  #  def test_save_with_url
  #    post = Post.new junk_title, junk_url
  #    mock = mock_file_save post
  #    File.stub(:write, mock) do
  #      refute(post.exists?)
  #      assert(post.save)
  #    end
  #  end
  #
  #  def test_save_when_invalid
  #    post = Post.new ''
  #    refute(post.valid?)
  #    refute(post.save)
  #  end
  #
  #  def test_save_when_exists
  #    post = Post.new 'Something'
  #    assert(post.exists?)
  #    refute(post.save)
  #  end
  #
  #  def mock_file_save(post)
  #    lambda do |file, content|
  #      assert_equal(post.full_path, file)
  #
  #      assert_match(/layout:\spost/, content)
  #      assert_match(/title:\s\"#{post.full_title}\"/, content)
  #      assert_match(/categories:\sruby/, content)
  #
  #      assert(content.end_with?(post.content))
  #    end
  #  end
end
