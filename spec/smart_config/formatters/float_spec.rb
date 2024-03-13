# frozen_string_literal: true

require 'spec_helper'

describe SmartConfig::Formatters::Float do
  describe '#format' do
    it 'formats into a float' do
      expect(described_class.format('41.5')).to be(41.5)
    end

    it 'handles nil' do
      expect(described_class.format(nil)).to be_nil
    end
  end
end
