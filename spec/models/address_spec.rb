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
      @hash = adrs.sikugun_hash 1
    end
    it "sikugun_hash count not 0" do
      @hash.count.should_not == 0
    end
  end
  context "get sikugun data from string" do
    before do
      adrs = Address.new
      @hash = adrs.sikugun_hash "1"
    end
    it "sikugun_hash count not 0" do
      @hash.count.should_not == 0
    end
  end

  context "get machi data" do
    before do
      adrs = Address.new
      @hash = adrs.machi_hash  1, 2
    end
    it "hash count not 0" do
      @hash.count.should_not == 0
    end
  end

  context "get zip" do
    before do
      adrs = Address.new
      @ret = adrs.find_zip 1,1,1
    end
    it "result is not nil" do
      @ret.nil?.should be_false
    end
  end
  context "get not found zip" do
    before do
      adrs = Address.new
      @ret = adrs.find_zip 0,1,1
    end
    it "result is nil" do
      @ret.nil?.should  be_true
    end
  end

end
