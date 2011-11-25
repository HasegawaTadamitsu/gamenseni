Gamenseni::Application.routes.draw do

  root :to => "gamen#new"
  match "/gamen/"         => "gamen#new"
  match "/gamen/confirm"  => "gamen#confirm"
  match "/gamen/reedit"   => "gamen#reedit"
  match "/gamen/create"   => "gamen#create"
  match "/gamen/complete" => "gamen#complete"
  match "/gamen/chg_select1"=> "gamen#chg_select1"
  match "/gamen/chg_select2"=> "gamen#chg_select2"
  match "/gamen/chg_select3"=> "gamen#chg_select3"
  match "/gamen/chg_select4"=> "gamen#chg_select4"
end
