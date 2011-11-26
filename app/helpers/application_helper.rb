# -*- coding: utf-8 -*-
module ApplicationHelper
  def hissu
    "*"
  end

  def my_select model, attr, hash, default_value
    tmp_hash=Hash.new
    hash.each do|key,value|
      tmp_hash[value]=key
    end
    select model,attr,tmp_hash,:selected=>default_value
  end

  def chg_select id,name,attr,hash,default_value,next_action
    tmp_hash={"選択してください"=>""}
    hash.each do|key,value|
      tmp_hash[value]=key
    end

    select name,attr,tmp_hash,
      options = { :selected=>default_value },
      html_options ={
         :onchange =>
          remote_function(:url => {:action => next_action},  
                          :with => "'kind_id[middle]=' + escape(this.value)"),
      :id => "#{id}"} 
  end

  def my_label_from_hash hash, key
    hash[key.to_i]
  end

end
