# frozen_string_literal: true

require 'spec_helper'

describe SmartConfig::Formatters::Boolean do
  describe '#format' do
    it 'formats `true` into true' do
      expect(described_class.format('true')).to be true
    end

    it 'formats `1` into true' do
      expect(described_class.format('1')).to be true
    end

    it 'formats `1` as an integer into true' do
      expect(described_class.format(1)).to be true
    end

    it 'formats true as an integer into true' do
      expect(described_class.format(true)).to be true
    end

    it 'formats any other value into false' do
      expect(described_class.format('false')).to be false
    end

    it 'formats nil into false' do
      expect(described_class.format(nil)).to be false
    end
  end
end
