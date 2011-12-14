
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
    ken = zero_padding ken_code,2
    ret = Hash.new
    data = Address.find(:all,:select =>["sikugun_code","sikugun_kanji"],
                        :conditions => ["ken_code = ?",ken ],
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
    ken = zero_padding ken_code,2
    sikugun= zero_padding sikugun_code,3
    ret = Hash.new
    data = Address.find(:all,
              :select =>["machi_code","machi_kanji"],
              :conditions => ["ken_code = ? and sikugun_code = ?",
                               ken,sikugun],
              :group => ["machi_code","machi_kanji"],
              :order => "machi_code" )
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

    ken = zero_padding ken_code,2
    sikugun = zero_padding sikugun_code,3
    machi = zero_padding machi_code,3

    data = Address.find(:all,
      :select =>["zip1","zip2","ken_kanji","sikugun_kanji","machi_kanji"], 
      :conditions =>
         ["ken_code = ? and sikugun_code = ? and machi_code = ?" ,
         ken,sikugun,machi])
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
         ["zip1 = ? and zip2 = ?", zip1.to_s ,zip2.to_s ])
    return nil if data.nil? || data.size == 0
    ret = data
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
   if result.nil? 
     ret = Hash.new
     ret[:zip1] = ""
     ret[:zip2] = ""
     return ret
   end
   ret = Hash.new
   ret[:zip1] = result[:zip1]
   ret[:zip2] = result[:zip2]
   return ret
  end

  def to_client_from_zip zip1,zip2
    raise GamenSeniError.new "zip1 over length.#{zip1}" \
        if zip1.nil? 

    result = find_by_zip zip1,zip2
    codes = common_address result


    ret = Hash.new
    ret[:ken_code] = codes[:ken_code] if !codes[:ken_code].nil?
    ret[:ken_hash] = ken_hash
    ret[:sikugun_code] = codes[:sikugun_code] if !codes[:sikugun_code].nil?
    ret[:sikugun_hash] = sikugun_hash codes[:ken_code]
    ret[:machi_code] = codes[:machi_code] if !codes[:machi_code].nil?
    ret[:machi_hash] = machi_hash codes[:ken_code],codes[:sikugun_code]
    return ret
  end

  private
  def common_address datas
    return {:ken_code => nil,:sikugn_code => nil,
            :machi_code => nil} if datas.nil?
    ken_code = nil
    sikugun_code = nil
    machi_code = nil
    datas.each do |data|
      ke = data[:ken_code]
      if ken_code.nil?
        ken_code = ke
      elsif ken_code != ke
        ken_code = nil
        break
      end
    end
    if ! ken_code.nil?
      datas.each do |data|
        siku = data[:sikugun_code]
        if sikugun_code.nil?
          sikugun_code = siku
        elsif sikugun_code != siku
          sikugun_code = nil
          break
        end
      end
    end
    if ! sikugun_code.nil?
      datas.each do |data|
        ma = data[:machi_code]
        if machi_code.nil?
          machi_code = ma
        elsif machi_code != ma
          machi_code = nil
          break
        end
      end
    end
    return {:ken_code => ken_code,:sikugun_code => sikugun_code,
            :machi_code => machi_code}
  end

  def zero_padding string,length
    str = string.to_s
    len = length.to_i
    zeros = "0" * len
    return (zeros + str)[- len..-1]
  end

end
