Risk2210::Application.routes.draw do
  
  ## Omniauth Sessions
  match '/auth/:provider/callback' => 'sessions#create'
  match '/auth/failure' => 'sessions#failure'
  match '/login' => 'sessions#new', :as => :login
  match '/logout' => 'sessions#destroy', :as => :logout
  
  root to: 'home#index'

end
