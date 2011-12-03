
class Address < ActiveRecord::Base
  
  def ken_hash
    ret = Hash.new
    data = Address.find(:all,:select =>["ken_code","ken_kanji"],
                        :group => ["ken_code","ken_kanji"],
                        :order => "ken_code")
    data.each  do | find_result |
      key = find_result[:ken_code]
      val = find_result[:ken_kanji]
      ret[key] = val
    end
    ret
  end

  def sikugun_hash ken_code
    return Hash.new if ken_code.nil?
  
    ret = Hash.new
    data = Address.find(:all,:select =>["sikugun_code","sikugun_kanji"],
                        :conditions => ["ken_code == ?", ken_code],
                        :group => ["sikugun_code","sikugun_kanji"],
                        :order => "sikugun_code")
    data.each  do | find_result |
      key = find_result[:sikugun_code]
      val = find_result[:sikugun_kanji]
      ret[key] = val
    end
    ret
  end

  def machi_hash ken_code,sikugun_code
    return Hash.new if ken_code.nil?
    return Hash.new if sikugun_code.nil?
  
    ret = Hash.new
    data = Address.find(:all,
              :select =>["machi_code","machi_kanji"],
              :conditions => ["ken_code == ? and sikugun_code == ?",
                               ken_code,sikugun_code],
              :group => ["machi_code","machi_kanji"],
              :order => "machi_code" )
    data.each  do | find_result |
      key = find_result[:machi_code]
      val = find_result[:machi_kanji]
      ret[key] = val
    end
    ret
  end

 def to_client_data ken,sikugun,machi
   ret= Hash.new
   ret[:ken]= ken_hash 
   ret[:sikugun]= sikugun_hash  ken
   ret[:machi]= machi_hash   ken,sikugun
   return ret
 end

end
