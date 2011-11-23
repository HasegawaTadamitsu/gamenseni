Gamenseni::Application.routes.draw do

  root :to => "gamen#new"
  match "/gamen/"         => "gamen#new"
  match "/gamen/confirm"  => "gamen#confirm"
  match "/gamen/reedit"   => "gamen#reedit"
  match "/gamen/create"   => "gamen#create"
  match "/gamen/complete" => "gamen#complete"
end
