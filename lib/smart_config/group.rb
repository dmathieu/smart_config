# frozen_string_literal: true

require 'yaml'

module SmartConfig
  #
  # Handles recursive subgroups of configurations
  #
  class Group
    include SmartConfig::Values

    def initialize(name, parent, &block)
      @name, @parent = name, parent
      instance_exec &block
    end

    private

    def data
      @data ||= @parent.get_path(@name)
    end
  end
end
