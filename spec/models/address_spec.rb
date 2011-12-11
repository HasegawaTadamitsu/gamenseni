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

  context "get by code" do
    before do
      adrs = Address.new
      @ret = adrs.find_by_code 99,99,99
    end
    it "result is  nil" do
      @ret.nil?.should be_true
    end
  end
  context "get by code" do
    before do
      adrs = Address.new
      @ret = adrs.find_by_code 1,1,1
    end
    it "result is not nil" do
      @ret.nil?.should be_false
    end
  end
  context "get not by code" do
    before do
      adrs = Address.new
      @ret = adrs.find_by_code 0,1,1
    end
    it "result is nil" do
      @ret.nil?.should  be_true
    end
  end

  context "get by zip" do
    before do
      adrs = Address.new
      @ret = adrs.find_by_zip 387,'0007'
    end
    it "result is nil" do
      @ret.nil?.should  be_false
    end
  end

  context "get not by zip" do
    before do
      adrs = Address.new
      @ret = adrs.find_by_zip 387,'9999'
    end
    it "result is nil" do
      @ret.nil?.should  be_true
    end
  end

  context "get not by zeropadding" do
    before do
      @adrs = Address.new
    end
    it "blank str should 0" do
      @adrs.send(:zero_padding, "", 1).should  =='0'
    end
    it " 1 and length 2  should 01" do
      @adrs.send(:zero_padding, "1", 2).should  =='01'
    end
    it " 1 and length 3  should 001" do
      @adrs.send(:zero_padding, "1", 3).should  =='001'
    end
    it " 1 and length 1  should 1" do
      @adrs.send(:zero_padding, "1", 1).should  =='1'
    end
    it " 11 and length 2  should 11" do
      @adrs.send(:zero_padding, "11", 2).should  =='11'
    end
    it " 023 and length 3  should 023" do
      @adrs.send(:zero_padding, "023", 3).should  =='023'
    end
  end

  context "to_client_from_zip" do
    before do
      adrs = Address.new
      @ret = adrs.to_client_from_zip '387','9999'
    end
    it "result is not nil" do
      @ret.nil?.should  be_false
    end
  end

  context "to_client_from_zip a nil " do
    before do
      adrs = Address.new
      @ret = adrs.to_client_from_zip nil,nil
    end
    it "result is not nil" do
      @ret.nil?.should  be_false
    end
  end

  context "common address is" do
    it " nil arg is not nil" do
      adrs = Address.new
      adrs.send(:common_address, nil).nil?.should  be_false
    end
    it " nill arg is not nil" do
      adrs = Address.new
      datas =Address.find(:all,:conditions=>["ken_code = ?",'01'])
      adrs.send(:common_address, datas).nil?.should  be_false
    end
    it " nill arg is not nil" do
      adrs = Address.new
      datas =Address.find(:all,
       :conditions=>["ken_code = ? and sikugun_code = ?",'01','001'])
      adrs.send(:common_address, datas).nil?.should  be_false
    end
    it " nill arg is not nil" do
      adrs = Address.new
      datas =Address.find(:all,
       :conditions=>["ken_code = ? and sikugun_code = ? and machi_code = ?",
        '01','001','001'])
      adrs.send(:common_address, datas).nil?.should  be_false
    end

  end

end
