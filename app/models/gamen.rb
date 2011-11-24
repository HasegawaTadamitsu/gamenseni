class Gamen < ActiveRecord::Base
  validates :title,
              :presence=>true,
              :numericality => true,
              :length=>{ :minimum =>10 },:allow_blank=>true
end
