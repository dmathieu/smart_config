# frozen_string_literal: true

require 'spec_helper'

describe SmartConfig::Values do
  let(:k) do
    Class.new do
      extend SmartConfig::Values

      value :foobar
      value :hello

      group :spanish do
        value :hola

        group :location do
          value :latitude
        end
      end

      def self.data
        [
          {
            'foobar' => 'hello',
            'spanish' => {
              'hola' => 'mundo',
              'location' => {
                'latitude' => '40.4637'
              }
            }
          },
          { 'hello' => 'world' }
        ]
      end
    end
  end

  describe '#keys' do
    it 'holds the list of keys' do
      expect(k.keys).to eql(%i[foobar hello spanish])
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
  end
end
