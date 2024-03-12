# frozen_string_literal: true

require 'yaml'

module SmartConfig
  #
  # Handles the retrieval of values, but with already provided data.
  #
  module Values
    attr_reader :namespace

    def value(name, *opts)
      @config ||= {}
      @config[name.to_sym] = opts.reduce({}, :merge)
    end

    def group(name, &)
      @config ||= {}
      @config[name.to_sym] ||= {}
      @config[name.to_sym][:group] = SmartConfig::Group.new([namespace, name].compact.flatten, walker, &)
    end

    def keys
      @config.keys
    end

    def method_missing(name, *args, &)
      return format_value(name, get_value(name)) if keys.include?(name)

      super
    end

    def respond_to_missing?(name, include_private = false)
      return true if keys.include?(name)

      super
    end

    def get_value(name)
      return @config[name][:group] if @config[name].key?(:group)

      path = walker.walk(full_name(name))
      return path.first unless path.first.nil?
      return @config[name][:default] if @config[name].key?(:default)

      raise SmartConfig::MissingConfigValue, full_name(name)
    end

    def format_value(name, value)
      @formatters ||= {}

      @formatters[name] ||= SmartConfig::Formatters.find(@config[name].fetch(:formatter, :string))
      @formatters[name].format(value)
    end

    private

    # Getting the data through a walker needs to be implemented by a lateral module
    def walker
      raise NotImplementedError
    end

    def full_name(name)
      [namespace, name.to_s].compact.flatten.join('.')
    end
  end
end
