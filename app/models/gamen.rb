# -*- coding: utf-8 -*-
class Gamen < ActiveRecord::Base
  validates :title,
              :presence=>true,
              :numericality => true,
              :length=>{ :minimum =>10 },:allow_blank=>true

  def self.select_data
    {
    0=>"現在の時刻",
    1=>"最後にアクセスしてから"
    }
  end

  attr_accessor :select_value

end
