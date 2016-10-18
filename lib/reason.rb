# frozen_string_literal: true
require 'yaml'

class Reason
  attr_reader :title

  class MissingYamlPathConfigError < StandardError; end

  def initialize(title)
    @title = title
  end

  def number
    return self.class.count + 1 unless exists?
    self.class.find(title).first
  end

  def exists?
    true if self.class.find title
  end

  def save
    return if exists?
    File.write self.class.yaml_path, save_content.to_yaml
  end

  def title_sym
    self.class.convert(title).to_sym
  end
  private :title_sym

  def save_content
    count = self.class.count + 1
    yaml_data[:reasons][title_sym] = [count, title]
    { reasons: yaml_data[:reasons] }
  end
  private :save_content

  def yaml_data
    @yaml_data ||= self.class.yaml_data
  end
  private :yaml_data

  def self.all
    yaml_data[:reasons]
  end

  def self.count
    all.size
  end

  def self.find(title)
    title_safe = convert(title)
    yaml_data[:reasons].fetch title_safe.to_sym, false
  end

  def self.yaml_path
    raise MissingYamlPathConfigError unless ENV['YAML_PATH']
    ENV['YAML_PATH']
  end

  class << self
    def convert(title)
      title.downcase.tr(" '-", '_').tr('~()?!:#', '')
    end

    def yaml_data
      return { reasons: {} } unless File.exist? yaml_path
      YAML.load_file yaml_path
    end
  end
end
