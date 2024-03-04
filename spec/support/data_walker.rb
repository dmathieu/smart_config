# frozen_string_literal: true

module SmartConfig
  module Spec
    module DataWalker
      include SmartConfig::Values

      private

      def walker
        @walker ||= SmartConfig::Walker.new(data)
      end
    end
  end
end
