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

  context "get sikugun data" do
    before do
      adrs = Address.new
      @hash = adrs.sikugun_hash '長野県'
    end
    it "sikugun_hash count not 0" do
      @hash.count.should_not == 0
    end
  end

  context "get machi data" do
    before do
      adrs = Address.new
      @hash = adrs.machi_hash '長野県','飯田市'
    end
    it "hash count not 0" do
      @hash.count.should_not == 0
    end
  end
end
