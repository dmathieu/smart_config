# frozen_string_literal: true

require 'yaml'

module SmartConfig
  #
  # Loads the data from any configured source and walks through it to find
  # values
  #
  class Walker
    def initialize(sources)
      @sources = sources
    end

    def walk(path)
      data.filter_map do |d|
        next if d[:data].nil?

        case d[:strategy]
        when :nested
          d[:data].dig(*path.split('.'))
        when :flat
          d[:data][path.tr('.', '_')]
        end
      end
    end

    private

    def data
      @data ||= @sources.filter_map do |s|
        {
          data: load_source(s[:data]),
          strategy: s[:strategy]
        }
      end
    end

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
