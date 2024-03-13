# frozen_string_literal: true

module SmartConfig
  module Formatters
    #
    # Float formats the value into a float
    class Float
      def self.format(value)
        return nil if value.nil?

        value.to_f
      end
    end
  end
end
