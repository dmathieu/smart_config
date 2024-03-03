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
      @sources.map do |s|
        load_source(s)
      end.compact
    end

    private

    def load_source(name)
      case name
      when Hash
        return name
      when /\.(yml|yaml)$/
        YAML.load_file(name)
      end

    rescue Errno::ENOENT
      nil
    end
  end
end
