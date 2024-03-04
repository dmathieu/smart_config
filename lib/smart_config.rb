# frozen_string_literal: true

#
# The main SmartConfig module. See documentation for the sub modules.
#
module SmartConfig
  class MissingConfigValue < StandardError; end
end

require 'smart_config/walker'
require 'smart_config/values'
require 'smart_config/group'
require 'smart_config/config'
require 'smart_config/version'
