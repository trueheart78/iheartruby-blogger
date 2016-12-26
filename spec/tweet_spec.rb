# frozen_string_literal: true
require_relative 'spec_helper'
require 'tweet'

RSpec.describe Tweet do
  describe '.update' do
    it 'returns true on success' do
      expect(described_class.update(post)).to be true
    end
  end

  TestPost = Struct.new :full_title, :url

  let(:post) do
    TestPost.new 'sample', 'http://www.example.com'
  end
end
