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

    javascript_tag (<<-EOS
    EOS
    )

    chg_select_url = url_for :action => 'chg_select'
    chg_machi_url    = url_for :action => 'chg_machi'
    chg_from_zip_url    = url_for :action => 'chg_from_zip'
    ken_id = address.ken_id
    sikugun_id = address.sikugun_id
    machi_id = address.machi_id
    zip1_id = address.zip1_id
    zip2_id = address.zip2_id
    msg_id = address.msg_id
    search_button_id = address.search_button_id

    javascript_tag (<<-EOS
    $(function() {
      var set_sending_msg = function(id){
        $("#"+id).html("sending");
      };
      var clear_msg = function(id){
        $("#"+id).html("");
      };

      var set_select_misentaku = function(id){
        var optionItems = new Array();
        var opt = new Option("選択してください","");
        opt.label = "選択してください";
        optionItems.push(opt);
        $("#" + id).empty();
        $("#" + id).append(optionItems);
      };

      var clear_zip = function(zip1_id,zip2_id) {
        $("#"+zip1_id).val("");
        $("#"+zip2_id).val("");
      };
      var set_zip = function(zip1_id, zip2_id, data){
        $("#"+zip1_id).val(data["zip1"]);
        $("#"+zip2_id).val(data["zip2"]);
      };

      var send_data = function(selecter) {
        send_data1 = $("##{ken_id}").val();
        send_data2 = $("##{sikugun_id}").val();
        send_data3 = $("##{machi_id}").val();
        send_zip1 = $("##{zip1_id}").val();
        send_zip2 = $("##{zip2_id}").val();
        var data = { selecter:selecter,
                     ken:send_data1,
                     sikugun:send_data2,
                     machi:send_data3,
                     zip1:send_zip1,
                     zip2:send_zip2};
        return data;
      };

      var set_select = function(selecter_id,data,default_key){
        var change_selecter_id = "";
        var optionItems = new Array();
        var item = new Option("選択してください","");
        item.label = "選択してください";
        optionItems.push(item);
        for(var key in data) { 
          var opt = new Option(data[key], key);
          opt.label = data[key];
          if( key == default_key) {
              opt.defaultSelected = true;
          }
          optionItems.push(opt);
        }
        $("#"+selecter_id).empty();
        $("#"+selecter_id).append(optionItems);
      };

      var onChangeSelect = function(selecter_id) {
         var aj = $.ajax( {
             type: "post",
             url:  "#{chg_select_url}",
             dataType: "json",
             data: send_data(selecter_id),
             beforeSend: function(){
               set_sending_msg("#{msg_id}");
             },
             success: function(response, status, xhr){
               var result_data = $.parseJSON(xhr.responseText);
              clear_zip("#{zip1_id}","#{zip2_id}");
              if( selecter_id == "#{ken_id}" ){
                change_selecter_id = "#{sikugun_id}";
                set_select_misentaku("#{machi_id}");
              } else if(selecter_id == "#{sikugun_id}" ){
                change_selecter_id = "#{machi_id}";
              } else {
                return;
              }
               set_select(change_selecter_id,result_data["hash"],"");
             },
             error:  function(){
               alert("error");
             },
             complete: function(){
               clear_msg("#{msg_id}");
             }
         });
      }
      var onChangeMachi = function(selecter_id) {
         var aj = $.ajax( {
             type: "post",
             url:  "#{chg_machi_url}",
             dataType: "json",
             data: send_data(selecter_id),
             beforeSend: function(){
               set_sending_msg("#{msg_id}");
             },
             success: function(response, status, xhr){
               var result_data = $.parseJSON(xhr.responseText);
               set_zip("#{zip1_id}","#{zip2_id}",result_data);
             },
             error:  function(){
               alert("error");
             },
             complete: function(){
               clear_msg("#{msg_id}");
             }
         });
      }
      $("##{ken_id}").change( function(){
                                onChangeSelect("#{ken_id}");
                               });
      $("##{sikugun_id}").change( function(){
                                    onChangeSelect("#{sikugun_id}");
                               } );
      $("##{machi_id}").change( function(){
                                  onChangeMachi("#{machi_id}");
                               } );

      var onSearch = function(ken_id,sikugun_id,machi_id){
         var aj = $.ajax( {
             type: "post",
             url:  "#{chg_from_zip_url}",
             dataType: "json",
             data: send_data(''),
             beforeSend: function(){
               set_sending_msg("#{msg_id}");
             },
             success: function(response, status, xhr){
               var result_data = $.parseJSON(xhr.responseText);
               set_select("#{ken_id}",result_data.ken_hash,
                                      result_data.ken_code);
               set_select("#{sikugun_id}",result_data.sikugun_hash,
                                          result_data.sikugun_code);
               set_select("#{machi_id}",result_data.machi_hash,
                                        result_data.machi_code);
             },
             error:  function(){
               alert("error");
             },
             complete: function(){
               clear_msg("#{msg_id}");
             }});
      };
      $("##{search_button_id}").live('click', function(){
                                 onSearch("#{ken_id}",
                                 "#{sikugun_id}","#{machi_id}");
                                 return false;  
                               } );
   });
   EOS
   )
  end

  def chg_select id,name,attr,hash,default_value
    select name,attr,hash.invert,
        options = { :include_blank => "選択してください",
                    :selected => default_value},
        html_options ={  :id => "#{id}" }
  end

  def my_label_from_hash hash, key
    hash[key.to_i]
  end
end
