# frozen_string_literal: true

require 'yaml'

module SmartConfig
  #
  # Handles recursive subgroups of configurations
  #
  class Group
    include SmartConfig::Values

    def initialize(name, parent, &)
      @name = name
      @parent = parent
      instance_exec(&)
    end

    private

    def data
      @data ||= @parent.get_path(@name)
    end
  end
end
