# frozen_string_literal: true

require 'yaml'

module SmartConfig
  #
  # Handles recursive subgroups of configurations
  #
  class Group
    include SmartConfig::Values

    def initialize(namespace, walker, &)
      @namespace = namespace
      @walker = walker
      instance_exec(&)
    end

    private

    attr_reader :walker
  end
end
