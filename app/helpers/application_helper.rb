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

  def chg_select_send_data_create_javascript adr

    action_url = url_for :action => 'chg_select1'

    javascript_tag (<<-EOS
    $(function() {
      $("#chg_select1").change( onChangeSelect1() );
      $("#chg_select2").change( onChangeSelect2() );
      $("#chg_select3").change( onChangeSelect3() );
      send_data = function() {
         send_data1= $('#chg_select1').val() ;
         send_data2= $('#chg_select2').val() ;
         send_data3= $('#chg_select3').val() ;
         var data = { chg_select1:send_data1,
                      chg_select2:send_data2,
                      chg_select3:send_data3};
         return data;
}
chg_select1_function() {
         send_data1= $('#chg_select1').val() ;
         send_data2= $('#chg_select2').val() ;
         send_data3= $('#chg_select3').val() ;
         var data = { chg_select1:send_data1,
                      chg_select2:send_data2,
                      chg_select3:send_data3};
         var aj = $.ajax( {
             type: 'post',
             async: false,
             url:  '#{action_url}',
             dataType: 'json',
             data: data,
             beforeSend: function(){
                   $('#msg').html('sending');
             },
             success: function(response, status, xhr){
                 var set_data = $.parseJSON(xhr.responseText)[0];
                 var optionItems = new Array();
                 $('#chg_select2').empty();
                 for(var key in set_data){ 
                   optionItems.push(new Option(set_data[key], key));
                 }
                 $('#chg_select2').append(optionItems);
             },
             error:  function(){
                    alert('error');
             },
             complete: function(){
                    $('#msg').html('');
             }
         });
      });
    });
   EOS
   )
  end

  def chg_select id,name,attr,hash,default_value
    tmp_hash= Hash.new
    hash.each do|key,value|
      tmp_hash[value]=key
    end
    select name,attr,tmp_hash,
        options = { :include_blank => '選択してください',
                    :selected => default_value},
        html_options ={  :id => "#{id}" }
  end

  def my_label_from_hash hash, key
    hash[key.to_i]
  end
end
