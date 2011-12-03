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

  def chg_select_send_data_create_javascript address

    action_url = url_for :action => 'chg_select'
    ken_id = address.ken_id
    sikugun_id = address.sikugun_id
    machi_id = address.machi_id

    javascript_tag (<<-EOS
    $(function() {
      send_data = function(selecter) {
        send_data1 = $('##{ken_id}').val();
        send_data2 = $('##{sikugun_id}').val();
        send_data3 = $('##{machi_id}').val();
        var data = { selecter:selecter,
                     ken:send_data1,
                     sikugun:send_data2,
                     machi:send_data3};
        return data;
      };
      set_sending_msg = function(){
        $('#msg').html('sending');
      };
      clear_msg = function(){
        $('#msg').html('');
      };
      set_select_misentaku = function(id){
        var optionItems = new Array();
        optionItems.push(new Option("選択してください",""));
        $("#" + id).empty();
        $("#" + id).append(optionItems);
      };

      set_select = function(selecter_id,data){
        var change_selecter_id = "";
        if( selecter_id == "#{ken_id}" ){
          change_selecter_id = "#{sikugun_id}";
          set_select_misentaku("#{machi_id}");
        } else if(selecter_id == "#{sikugun_id}" ){
          change_selecter_id = "#{machi_id}";
        } else {
          return;
        }
        var optionItems = new Array();
        optionItems.push(new Option("選択してください",""));
        for(var key in data){ 
          optionItems.push(new Option(data[key], key));
        }
        $("#"+change_selecter_id).empty();
        $("#"+change_selecter_id).append(optionItems);
      };
      onChangeSelect = function(selecter_id) {
         var aj = $.ajax( {
             type: 'post',
             url:  '#{action_url}',
             dataType: 'json',
             data: send_data(selecter_id),
             beforeSend: function(){
               set_sending_msg();
             },
             success: function(response, status, xhr){
               var result_data = $.parseJSON(xhr.responseText);
               set_select(selecter_id,result_data['hash']);
             },
             error:  function(){
               alert('error');
             },
             complete: function(){
               clear_msg();        
             }
         });
      }
      $("##{ken_id}").change( function(){
                                onChangeSelect('#{ken_id}');
                               });
      $("##{sikugun_id}").change( function(){
                                    onChangeSelect('#{sikugun_id}');
                               } );
      $("##{machi_id}").change( function(){
                                  onChangeSelect('#{machi_id}');
                               } );
   });
   EOS
   )
  end

  def chg_select id,name,attr,hash,default_value
    select name,attr,hash.invert,
        options = { :include_blank => '選択してください',
                    :selected => default_value},
        html_options ={  :id => "#{id}" }
  end

  def my_label_from_hash hash, key
    hash[key.to_i]
  end
end
