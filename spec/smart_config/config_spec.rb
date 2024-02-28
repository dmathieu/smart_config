# frozen_string_literal: true

require 'spec_helper'

describe SmartConfig::Config do
  let(:k) do
    Class.new do
      extend SmartConfig::Config
      config_path 'spec/fixtures/config.yaml'

      value :foobar
      value :hello
    end
  end

  describe '#value' do
    # We implicitly call #value in the class definition above
    it 'can set a value' do
      expect(k.keys).to eql(%i[foobar hello])
    end
  end

  describe '#load!' do
    it 'loads the data' do
      expect(k.load!).to be true
    end

    it 'makes the data accessible' do
      k.load!
      expect(k.foobar).to eql('hello')
    end

    it 'falls back to the environment variable value' do
      with_environment('HELLO' => 'WORLD') do
        k.load!
        expect(k.hello).to eql('WORLD')
      end
    end
  end
end
