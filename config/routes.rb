Rails.application.routes.draw do
  root :to => 'creditcard#index'
  match "/creditcard/validate_card",             :to => "creditcard#validate_card", :via => [:post]
  
end
