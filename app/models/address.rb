
class Address < ActiveRecord::Base
  
  def ken_hash
    ret = Hash.new
    data = Address.find(:all,:select =>"ken_kanzi", :group => "ken_kanzi")
    data.each  do | find_result |
      val = find_result[:ken_kanzi]
      ret[val] = val
    end
    ret
  end

end
