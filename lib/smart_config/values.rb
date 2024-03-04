# frozen_string_literal: true

require 'yaml'

module SmartConfig
  #
  # Handles the retrieval of values, but with already provided data.
  #
  module Values
    attr_reader :namespace

    def value(name)
      @config ||= {}
      @config[name.to_sym] = {}
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
      path = walker.walk([namespace, name.to_s].compact.flatten.join('.'))

      case @config[name]
      when SmartConfig::Group
        @config[name]
      else
        path.first
      end
    end

    private

    # Getting the data through a walker needs to be implemented by a lateral module
    def walker
      raise NotImplementedError
    end
  end
end
