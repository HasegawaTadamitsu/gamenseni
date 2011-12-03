# -*- coding: utf-8 -*-

require 'spec_helper'

describe 'address 正常系' do
  context "get ken data" do
    before do
      adrs = Address.new
      @ken_hash = adrs.ken_hash
    end
    it "ken_hash count 47" do
      @ken_hash.count.should == 47
    end
  end
end
