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
  attr_accessor :select1_value
  attr_accessor :select2_value
  attr_accessor :select3_value
  attr_accessor :select4_value


  def select1_hash
    { 1  => 'abc', 2 => 'def' }
  end
  
  def select2_hash
    if select1_value
      return { 1 => 'select2',2 =>'xxx' }
    end
    Hash.new
  end
  
  def select3_hash
    if select2_value
      return { 1 => 'select3',2 =>'yy' }
    end
    Hash.new
  end
  
  def select4_hash
    if select3_value
      return  { 1 => 'select4',2 =>'yy' }
    end
    Hash.new
  end

end
