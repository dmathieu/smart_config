# frozen_string_literal: true

require 'yaml'

module SmartConfig
  #
  # Loads the data from any configured source
  #
  class Data
    def initialize(sources)
      @sources = sources
    end

    def data
      @sources.filter_map do |s|
        load_source(s)
      end
    end

    private

    def load_source(name)
      case name
      when Hash
        name
      when /\.(yml|yaml)$/
        YAML.load_file(name)
      end
    rescue Errno::ENOENT
      nil
    end
  end
end
