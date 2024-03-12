# frozen_string_literal: true

require 'spec_helper'

describe SmartConfig::Values do
  let(:k) do
    Class.new do
      # rubocop:disable Metrics/MethodLength
      def self.data
        [
          {
            data: {
              'foobar' => 'hello',
              'spanish' => {
                'hola' => 'mundo',
                'location' => {
                  'latitude' => '40.4637'
                }
              },
              'with_formatter' => '42'
            },
            strategy: :nested
          },
          {
            data: { 'hello' => 'world' },
            strategy: :flat
          }
        ]
      end
      # rubocop:enable Metrics/MethodLength

      extend SmartConfig::Spec::DataWalker

      value :foobar
      value :hello

      value :with_default, default: 'my default'
      value :with_nil_default, default: nil
      value :without_default

      value :with_formatter, formatter: :integer

      group :spanish do
        value :hola

        group :location do
          value :latitude
        end
      end
    end
  end

  describe '#keys' do
    it 'holds the list of keys' do
      expect(k.keys).not_to be_empty
    end
  end

  describe 'reading values' do
    it 'makes the data accessible' do
      expect(k.foobar).to eql('hello')
    end

    it 'makes data accessible in a subgroup' do
      expect(k.spanish.hola).to eql('mundo')
    end

    it 'makes data accessible in a subgroup of a subgroup' do
      expect(k.spanish.location.latitude).to eql('40.4637')
    end

    it 'falls back to the second list of data' do
      expect(k.hello).to eql('world')
    end

    it 'raises for unknown values' do
      expect do
        k.bonjour
      end.to raise_error(NoMethodError)
    end

    it 'gets the default value' do
      expect(k.with_default).to eql('my default')
    end

    it 'gets the default value when it is nil' do
      expect(k.with_nil_default).to be_nil
    end

    it 'raises if no value could be found' do
      expect do
        k.without_default
      end.to raise_error(SmartConfig::MissingConfigValue)
    end

    it 'gets a formatted value' do
      expect(k.with_formatter).to be(42)
    end
  end

  describe '#respond_to_missing?' do
    it 'knows the method' do
      expect(k.send(:respond_to_missing?, :foobar)).to be true
    end

    it 'does not know the method' do
      expect(k.send(:respond_to_missing?, :nonexistent)).to be false
    end
  end
end
