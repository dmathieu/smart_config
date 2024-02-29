# frozen_string_literal: true

require 'yaml'

module SmartConfig
  #
  # Handles the retrieval of values, but with already provided data.
  #
  module Values
    def value(name)
      @config ||= {}
      @config[name.to_sym] = {}
    end

    def group(name, &)
      @config ||= {}
      @config[name.to_sym] = SmartConfig::Group.new(name, self, &)
    end

    def keys
      @config.keys
    end

    def method_missing(name, *args, &)
      return get_value(name) if keys.include?(name)

      super
    end

    def respond_to_missing?(name, include_private = false)
      return true if keys.include?(name)

      super
    end

    def get_value(name)
      path = get_path(name)

      case @config[name]
      when SmartConfig::Group
        @config[name]
      else
        path.first
      end
    end

    def get_path(name)
      name = name.to_s
      data.filter_map do |a|
        next a[name] if a.key?(name)

        fd = a
             .select { |e| e.start_with? "#{name}_" }
             .transform_keys { |k| k.delete_prefix("#{name}_") }
        fd unless fd.empty?
      end
    end

    private

    # Getting the data needs to be implemented by a lateral module
    def data
      raise NotImplementedError
    end
  end
end
