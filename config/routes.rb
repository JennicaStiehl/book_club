Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
root  'welcome#index'

get "Jennica's Github", to: redirect('https://github.com/JennicaStiehl')

  resources :users do
    resources :reviews
  end
  resources :authors
  resources :books
  resources :reviews
end
