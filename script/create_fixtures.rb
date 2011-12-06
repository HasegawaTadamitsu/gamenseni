logger = RAILS_DEFAULT_LOGGER
logger.info "Start batch"

logger.info "End batch"

ken_code = "10"

datas = Address.find(:all,
  :conditions => ["to_number(ken_code,'999') = to_number(?,'999')",ken_code],
       :order => ["ken_code","sikugun_code","machi_code"])

datas.collect do |data|
  print  data.attributes.to_yaml
end
