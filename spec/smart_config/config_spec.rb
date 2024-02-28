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
        end.to raise_error(Errno::ENOENT, 'No such file or directory @ rb_sysopen - config/config.yaml')
      end
    end

    describe 'with a config path specified' do
      let(:k) do
        Class.new do
          extend SmartConfig::Config
          config_path 'spec/fixtures/config.yaml'

          value :foobar
          value :hello
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

      it 'falls back to environment variables' do
        with_environment({ 'HELLO' => 'world' }) do
          expect(k.hello).to eql('world')
        end
      end
    end
  end
end
