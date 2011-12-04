# -*- coding: utf-8 -*-
class Gamen < ActiveRecord::Base
  validates :title,
              :presence=>true,
              :numericality => true,
              :length=>{ :minimum =>10 },:allow_blank=>true

  after_initialize :do_after_initialize

  def self.select_data
    {
    0=>"DBを使わないセレクト",
    1=>"モデルに定義でいいのかなぁ。"
    }
  end

  attr_accessor :select_value
  attr_accessor :select1_value
  attr_accessor :select2_value
  attr_accessor :select3_value
  attr_accessor :zip1,:zip2
  attr_accessor :address_selecter


  def do_after_initialize
    @address_selecter = Address.new
    @address_selecter.ken_id = "ken_ID"
    @address_selecter.sikugun_id = "SikuGUn_ID"
    @address_selecter.machi_id = "Machi_ID"
    @address_selecter.msg_id = "Message_ID"
    @address_selecter.zip1_id = "zip1_ID"
    @address_selecter.zip2_id = "zip2_ID"
  end

end
