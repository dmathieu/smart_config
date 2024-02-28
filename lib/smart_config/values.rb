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
      name = name.to_s

      data.each do |a|
        return a[name] if a.key?(name)
      end

      nil
    end

    private

    # Getting the data needs to be implemented by a lateral module
    def data
      raise NotImplementedError
    end
  end
end
