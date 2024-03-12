# frozen_string_literal: true

module SmartConfig
  #
  # Formatters define behaviors to format values into another type
  # This is especially useful for environment variables, which are always strings
  #
  module Formatters
    def self.find(format)
      SmartConfig::Formatters.const_get(camelize(format))
    end

    def self.camelize(format)
      format.to_s.split('_').collect(&:capitalize).join
    end
  end
end

require 'smart_config/formatters/string'
require 'smart_config/formatters/integer'
