# frozen_string_literal: true
require 'yaml'

class Reason
  class MissingYamlPathConfigError < StandardError
  end

  attr_reader :reason, :description

  def initialize(reason:, description: nil)
    @reason = reason
    @description = description
  end

  def self.all
    yaml_data[:reasons]
  end

  def self.count
    yaml_data[:count]
  end

  def self.find(reason)
    reason_safe = convert(reason)
    yaml_data[:reasons].fetch reason_safe.to_sym, false
  end

  def self.yaml_path
    raise MissingYamlPathConfigError unless ENV['YAML_PATH']
    ENV['YAML_PATH']
  end

  class << self
    def convert(reason)
      reason.downcase.tr(" '-", '_').tr('~()?!:#', '')
    end

    def yaml_data
      return { count: 0, reasons: {} } unless File.exist? yaml_path
      YAML.load_file yaml_path
    end
  end
end
