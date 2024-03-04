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
      @config[name.to_sym] = SmartConfig::Group.new([namespace, name].compact.flatten, walker, &)
    end

    def keys
      @config.keys
    end

    def method_missing(name, *args, &)
      return get_value(name) if keys.include?(name)

      super
    end

    def respond_to_missing?(name, include_private = false)
      return true if keys.include?(name)

      super
    end

    def get_value(name)
      return @config[name] if @config[name].is_a?(SmartConfig::Group)

      path = walker.walk([namespace, name.to_s].compact.flatten.join('.'))
      return path.first unless path.first.nil?
      return @config[name][:default] if @config[name].key?(:default)

      raise SmartConfig::MissingConfigValue, name
    end

    private

    # Getting the data through a walker needs to be implemented by a lateral module
    def walker
      raise NotImplementedError
    end
  end
end
