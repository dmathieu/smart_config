# frozen_string_literal: true

module SmartConfig
  module Formatters
    #
    # Boolean formats the value into a boolean
    class Boolean
      def self.format(value) # rubocop:disable Naming/PredicateMethod -- This is not a predicate method
        ['true', '1', 1, true].include?(value)
      end
    end
  end
end
