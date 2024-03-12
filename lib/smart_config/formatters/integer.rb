# frozen_string_literal: true

module SmartConfig
  module Formatters
    #
    # Integer formats the value into an integer
    class Integer
      def self.format(value)
        return nil if value.nil?
        value.to_i
      end
    end
  end
end
