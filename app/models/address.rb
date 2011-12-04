
class Address < ActiveRecord::Base

  attr_accessor :ken_id
  attr_accessor :sikugun_id
  attr_accessor :machi_id
  attr_accessor :msg_id
  attr_accessor :zip1_id,:zip2_id
  
  def ken_hash
    ret = Hash.new
    data = Address.find(:all,:select =>["ken_code","ken_kanji"],
                        :group => ["ken_code","ken_kanji"],
                        :order => "id")
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
                        :order => "id")
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
              :order => "id" )
    data.each  do | find_result |
      key = find_result[:machi_code]
      val = find_result[:machi_kanji]
      ret[key] = val
    end
    ret
  end

  def find_zip ken_code,sikugun_code,machi_code
    return nil if ken_code.nil?
    return nil if sikugun_code.nil?
    return nil if machi_code.nil?

    data = Address.find(:all,
      :select =>["zip"], :conditions =>
           ["ken_code == ? and sikugun_code == ? and machi_code == ?" ,
             ken_code,sikugun_code,machi_code])
    return nil if data.nil? || data.size == 0
    ret = data.first[:zip]
  end

 def to_client_data selecter_id,ken,sikugun,machi
   ret= Hash.new
   case  selecter_id
   when @ken_id
      ret[:hash]= sikugun_hash  ken
   when @sikugun_id
     ret[:hash]=  machi_hash ken,sikugun
   when @machi_id
   else
     raise BadParameterError.new("bad param #{selecter_id}")
   end
   return ret
 end

 def to_client_zip selecter_id,ken,sikugun,machi
   zip = find_zip  ken,sikugun,machi
   ret = Hash.new
   ret[:zip1] = zip[0...3]
   ret[:zip2] = zip[3...7]
   return ret
 end
end
