Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root: '/'
  
  resources :books do
    resources :reviews
  end
  resources :authors
  resources :users
  resources :reviews
end
