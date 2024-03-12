# frozen_string_literal: true

require 'spec_helper'

describe SmartConfig::Formatters::String do
  describe '#format' do
    it 'formats into a string' do
      expect(described_class.format('hello')).to eql('hello')
    end

    it 'handles nil' do
      expect(described_class.format(nil)).to be_nil
    end
  end
end
