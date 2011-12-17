# -*- coding: utf-8 -*-

require 'spec_helper'

describe 'address 正常系' do
  context "get ken data" do
    it "ken_hash count 47" do
      adrs = Address.new
      ken_hash = adrs.ken_hash
      ken_hash.count.should == 47
    end
  end

  context "get sikugun data" do
    it "sikugun_hash count not 0" do
      adrs = Address.new
      hash = adrs.sikugun_hash 1
      hash.count.should_not == 0
    end
    it "sikugun_hash count not 0" do
      adrs = Address.new
      hash = adrs.sikugun_hash "1"
      hash.count.should_not == 0
    end
  end

  context "get machi data" do
    it "hash count not 0" do
      adrs = Address.new
      hash = adrs.machi_hash  1, 2
      hash.count.should_not == 0
    end
  end

  context "get by code" do
    it "result is  nil" do
      adrs = Address.new
      ret = adrs.find_by_code 99,99,99
      ret.nil?.should be_true
    end
    it "result is not nil" do
      adrs = Address.new
      ret = adrs.find_by_code 1,1,1
      ret.nil?.should be_false
    end
    it "result is nil" do
      adrs = Address.new
      ret = adrs.find_by_code 0,1,1
      ret.nil?.should  be_true
    end
  end
 
  context "get by zip" do
    it "result is nil" do
      adrs = Address.new
      adrs.send(:find_by_zip, 387,'0007' ).nil?.should  be_false
    end
    it "result is nil" do
      adrs = Address.new
      adrs.send(:find_by_zip, 387,'9999' ).nil?.should  be_true
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
      @adrs = Address.new
    end
    it "result is parameter error" do
      lambda { @adrs.to_client_from_zip nil,'9999' }.should 
                                raise_error( ParameterError)
      lambda { @adrs.to_client_from_zip '999',nil }.should 
                                raise_error( ParameterError)
      lambda { @adrs.to_client_from_zip '123456','' }.should 
                                raise_error( ParameterError)
      lambda { @adrs.to_client_from_zip '','12345678' }.should 
                                raise_error( ParameterError)
    end
  end

  context "common address is" do
    it " nil arg is not nil" do
      adrs = Address.new
      adrs.send(:common_address, nil).nil?.should  be_false
    end
    it " common ken other is nil." do
      adrs = Address.new
      datas =Address.find(:all,:conditions=>["ken_code = ?",'01'])
      ret=adrs.send(:common_address, datas)
      ret[:ken_code].to_i.should  == 1
      ret[:sikugun_code].nil?.should  be_true
      ret[:machi_code].nil?.should  be_true
    end
    it " common ken,sikugun other is nil." do
      adrs = Address.new
      datas =Address.find(:all,:conditions=>[
                        "ken_code = ? and sikugun_code=?",'01','001'])
      ret=adrs.send(:common_address, datas)
      ret[:ken_code].to_i.should  == 1
      ret[:sikugun_code].to_i.should  == 1
      ret[:machi_code].nil?.should  be_true
    end

    it " common all." do
      adrs = Address.new
      datas =Address.find(:all,:conditions=>[
          "ken_code = ? and sikugun_code=? and machi_code = ?",
                                             '01','001','001'])
      ret=adrs.send(:common_address, datas)
      ret[:ken_code].to_i.should  == 1
      ret[:sikugun_code].to_i.should  == 1
      ret[:machi_code].to_i.should  == 1
    end
  end
end
