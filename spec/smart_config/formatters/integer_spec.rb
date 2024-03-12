# frozen_string_literal: true

require 'spec_helper'

describe SmartConfig::Formatters::Integer do
  describe '#format' do
    it 'formats into an integer' do
      expect(described_class.format('42')).to eql(42)
    end

    it 'handles nil' do
      expect(described_class.format(nil)).to be_nil
    end
  end
end
