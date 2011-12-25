Gamenseni::Application.routes.draw do

  root :to => "gamen#new"
  match "/gamen/"         => "gamen#new"
  match "/gamen/confirm"  => "gamen#confirm"
  match "/gamen/reedit"   => "gamen#reedit"
  match "/gamen/create"   => "gamen#create"
  match "/gamen/complete" => "gamen#complete"
  match "/gamen/chg_select"=> "gamen#chg_select"
  match "/gamen/chg_machi"=> "gamen#chg_machi"
  match "/gamen/chg_from_zip"=> "gamen#chg_from_zip"
end
