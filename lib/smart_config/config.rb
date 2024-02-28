# frozen_string_literal: true

require 'yaml'

module SmartConfig
  #
  # Allows creating static configurations that rely on YAML files, or fall back
  # to environment variables
  #
  module Config
    @@config = {} # rubocop:disable Style/ClassVars

    def value(name)
      @@config[name.to_sym] = {}
    end

    def keys
      @@config.keys
    end

    def config_path(path)
      @@config_path = path # rubocop:disable Style/ClassVars
    end

    def load!
      !@@data.nil?
    rescue NameError
      @@data = YAML.load_file(config_file_path) # rubocop:disable Style/ClassVars
      !@@data.nil?
    end

    def method_missing(name, *args, &)
      return get_value(name) if keys.include?(name)

      super
    end

    def respond_to_missing?(name, include_private = false)
      keys.include?(name)
      super
    end

    private

    def config_file_path
      @@config_path
    rescue NameError
      'config/config.yaml'
    end

    def get_value(name)
      name = name.to_s
      return @@data[name] if @@data.key?(name)

      ENV.fetch(name.upcase, nil)
    end
  end
end
