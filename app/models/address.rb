
class Address < ActiveRecord::Base

  attr_accessor :ken_id
  attr_accessor :sikugun_id
  attr_accessor :machi_id
  attr_accessor :msg_id
  attr_accessor :zip1_id,:zip2_id
  attr_accessor :search_button_id

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

  def find_by_code ken_code,sikugun_code,machi_code
    return nil if ken_code.nil?
    return nil if sikugun_code.nil?
    return nil if machi_code.nil?

    data = Address.find(:all,
      :select =>["zip","ken_kanji","sikugun_kanji","machi_kanji"], 
      :conditions =>
         ["ken_code == ? and sikugun_code == ? and machi_code == ?" ,
         ken_code,sikugun_code,machi_code])
    return nil if data.nil? || data.size == 0
    raise "unkown fild.count != 1.#{ken_code}/#{sikugun_code}/#{machi_code}" \
                   if  data.size != 1
    ret = data.first
  end

  def find_by_zip zip1,zip2
    return nil if zip1.nil?
    return nil if zip2.nil?
    data = Address.find(:all,
      :conditions =>
         ["zip == ?",  "" + zip1.to_s + zip2.to_s ])
    return nil if data.nil? || data.size == 0
    ret = data.first
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
   result = find_by_code  ken,sikugun,machi
   ret = Hash.new
   ret[:zip1] = result[:zip][0...3]
   ret[:zip2] = result[:zip][3...7]
   return ret
 end

 def to_client_from_zip zip1,zip2
   result = find_by_zip zip1,zip2
   ret = Hash.new
   ret[:ken_code] = result[:ken_code] if !result.nil?
   ret[:ken_hash] = ken_hash
   ret[:sikugun_code] = result[:sikugun_code]
   ret[:sikugun_hash] = sikugun_hash result[:ken_code]
   ret[:machi_code] = result[:machi_code]
   ret[:machi_hash] = machi_hash result[:ken_code],result[:sikugun_code]
   return ret
 end

end
