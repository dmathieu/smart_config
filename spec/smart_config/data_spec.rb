# frozen_string_literal: true

require 'spec_helper'

describe SmartConfig::Data do
  it 'loads data from a hash' do
    d = described_class.new([{'hello' => 'world'}])
    expect(d.data).to eql([{'hello' => 'world'}])
  end

  it 'loads data from a file' do
    d = described_class.new(['spec/fixtures/config.yaml'])
    expect(d.data).to eql([{"foobar"=>"hello", "subgroup"=>{"foobar"=>"world"}}])
  end

  it 'skips missing files' do
    d = described_class.new(['spec/fixtures/missing_config.yml'])
    expect(d.data).to eql([])
  end
end
