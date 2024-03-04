# frozen_string_literal: true

require 'spec_helper'

describe SmartConfig::Walker do
  describe '#walk' do
    describe 'with a nested strategy' do
      it 'loads data from a hash' do
        d = described_class.new([
          { data: { 'hello' => 'world' }, strategy: :nested }
        ])
        expect(d.walk('hello')).to eql(['world'])
      end

      it 'loads data from a file' do
        d = described_class.new([{ data: 'spec/fixtures/config.yaml', strategy: :nested }])
        expect(d.walk('foobar')).to eql(['hello'])
        expect(d.walk('subgroup.foobar')).to eql(['world'])
      end

      it 'skips missing files' do
        d = described_class.new([{ data: 'spec/fixtures/missing_config.yml', strategy: :nested }])
        expect(d.walk('foobar')).to eql([])
      end

      it 'loads data from two file sources' do
        d = described_class.new([
          { data: { 'hello' => 'world' }, strategy: :nested },
          { data: { 'hello' => 'mundo' }, strategy: :nested }
        ])
        expect(d.walk('hello')).to eql(%w[world mundo])
      end
    end

    describe 'with a flat strategy' do
      it 'loads data from a hash' do
        d = described_class.new([
          { data: { 'subgroup_hello' => 'world' }, strategy: :flat }
        ])
        expect(d.walk('subgroup.hello')).to eql(['world'])
      end

      it 'loads data from two file sources' do
        d = described_class.new([
          { data: { 'hello' => 'world' }, strategy: :flat },
          { data: { 'hello' => 'mundo' }, strategy: :flat }
        ])
        expect(d.walk('hello')).to eql(%w[world mundo])
      end
    end
  end
end
