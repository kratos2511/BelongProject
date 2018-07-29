Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  
  get '/items' => 'home#items'
  post '/user_action' => 'home#user_action'
end
