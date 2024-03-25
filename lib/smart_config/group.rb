# frozen_string_literal: true

require 'yaml'

module SmartConfig
  #
  # Handles recursive subgroups of configurations
  #
  class Group
    include SmartConfig::Values

    def initialize(namespace, walker_fn, &)
      @namespace = namespace
      @walker_fn = walker_fn
      instance_exec(&)
    end

    private

    def walker
      @walker ||= @walker_fn.call
    end
  end
end
