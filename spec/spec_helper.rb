# frozen_string_literal: true

require 'bundler/setup'
Bundler.setup

require 'smart_config'
Dir[File.join(Dir.pwd, 'spec/support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.include EnvironmentHelper
end
