# frozen_string_literal: true

require 'spec_helper'

describe SmartConfig::Formatters do
  describe '#find' do
    it 'finds a known formatter' do
      expect(described_class.find(:string)).to eql(SmartConfig::Formatters::String)
    end

    it 'cannot find an unknown formatter' do
      expect do
        described_class.find(:unknown)
      end.to raise_error(NameError)
    end
  end
end
