# frozen_string_literal: true

require 'yaml'

module SmartConfig
  #
  # Allows creating static configurations that rely on YAML files, or fall back
  # to environment variables
  #
  module Config
    include Values

    def config_path(path)
      @config_path = path
    end

    private

    def config_file_path
      return 'config/config.yaml' if @config_path.nil?

      @config_path
    end

    def data
      @data ||= [
        YAML.load_file(config_file_path),
        ENV.to_h.transform_keys(&:downcase)
      ]
    end
  end
end
