# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'smart_config/version'

Gem::Specification.new do |spec|
  spec.name        = 'smart_config'
  spec.version     = SmartConfig::VERSION
  spec.authors     = ['Damien MATHIEU']
  spec.email       = ['42@dmathieu.com']

  spec.summary     = 'A DLS for reading and accessing static configuration'
  spec.description = 'Define and access static configuration, from a YAML config file, or environment variables'
  spec.homepage    = 'https://github.com/dmathieu/smart_config'
  spec.license     = 'MIT'

  spec.files = Dir.glob('lib/**/*.rb') + Dir.glob('*.md') + ['LICENSE']
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 3.0'

  spec.metadata['rubygems_mfa_required'] = 'true'
end
