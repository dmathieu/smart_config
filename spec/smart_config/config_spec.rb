# frozen_string_literal: true

require 'spec_helper'

describe SmartConfig::Config do
  describe '#config_path' do
    describe 'with no config path specified' do
      let(:k) do
        Class.new do
          extend SmartConfig::Config

          value :foobar
        end
      end

      it 'tries loading the default config path' do
        expect do
          k.foobar
        end.to raise_error(SmartConfig::MissingConfigValue)
      end
    end

    describe 'with a config path specified' do
      let(:k) do
        Class.new do
          extend SmartConfig::Config
          
          config_path 'spec/fixtures/config.yaml'

          value :foobar
          value :hello

          group :subgroup do
            value :foobar
            value :env
          end
        end
      end

      it 'only loads the data once' do
        expect do
          k.config_path '/foo/bar'
        end.not_to change(k, :foobar)
      end

      it 'loads the data' do
        expect(k.foobar).to eql('hello')
      end

      it 'loads the data from a subgroup' do
        expect(k.subgroup.foobar).to eql('world')
      end

      it 'falls back to environment variables' do
        with_environment({ 'HELLO' => 'world' }) do
          expect(k.hello).to eql('world')
        end
      end

      it 'falls back to environment variables for subgroups' do
        with_environment({ 'SUBGROUP_ENV' => 'in a subgroup' }) do
          expect(k.subgroup.env).to eql('in a subgroup')
        end
      end
    end
  end
end
