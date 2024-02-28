# frozen_string_literal: true

require 'yaml'

module SmartConfig
  #
  # Handles the retrieval of values, but with already provided data.
  #
  module Values
    def value(name)
      @config ||= {}
      @config[name.to_sym] = {}
    end

    def group(name, &block)
      @config ||= {}
      @config[name.to_sym] = SmartConfig::Group.new(name, self, &block)
    end

    def keys
      @config.keys
    end

    def method_missing(name, *args, &)
      return get_value(name) if keys.include?(name)

      super
    end

    def respond_to_missing?(name, include_private = false)
      keys.include?(name)
      super
    end

    def get_value(name)
      path = get_path(name)

      case @config[name]
      when SmartConfig::Group
        return @config[name]
      else
        return path.first
      end
    end

    def get_path(name)
      name = name.to_s
      data.map{|a| a[name] }.compact
    end

    private

    # Getting the data needs to be implemented by a lateral module
    def data
      raise NotImplementedError
    end
  end
end
