# -*- coding: utf-8 -*-
class Gamen < ActiveRecord::Base
  validates :title,
              :presence=>true,
              :numericality => true,
              :length=>{ :minimum =>10 },:allow_blank=>true

  after_initialize :do_after_initialize

  def self.select_data
    {
    0=>"現在の時刻",
    1=>"最後にアクセスしてから"
    }
  end

  attr_accessor :select_value
  attr_accessor :select1_value
  attr_accessor :select2_value
  attr_accessor :select3_value
  attr_accessor :select4_value
  attr_accessor :address_selecter


  def do_after_initialize
    @address_selecter = Address.new
    @address_selecter.ken_id = "ken_ID"
    @address_selecter.sikugun_id = "SikuGUn_ID"
    @address_selecter.machi_id = "Machi_ID"
  end

end
