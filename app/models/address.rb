
class Address < ActiveRecord::Base
  
  def ken_hash
    ret = Hash.new
    data = Address.find(:all,:select =>"ken_kanji", :group => "ken_kanji")
    data.each  do | find_result |
      val = find_result[:ken_kanji]
      ret[val] = val
    end
    ret
  end

  def sikugun_hash ken_kanji
    return Hash.new if ken_kanji.nil?
  
    ret = Hash.new
    data = Address.find(:all,:select =>"sikugun_kanji",
                        :conditions => ["ken_kanji == ?", ken_kanji],
                        :group => "sikugun_kanji")
    data.each  do | find_result |
      val = find_result[:sikugun_kanji]
      ret[val] = val
    end
    ret
  end

  def machi_hash ken_kanji,sikugun_kanji
    return Hash.new if ken_kanji.nil?
    return Hash.new if sikugun_kanji.nil?
  
    ret = Hash.new
    data = Address.find(:all,
              :select =>"machi_kanji",
              :conditions => ["ken_kanji == ? and sikugun_kanji == ?",
                               ken_kanji,sikugun_kanji],
              :group => "machi_kanji")
    data.each  do | find_result |
      val = find_result[:machi_kanji]
      ret[val] = val
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
