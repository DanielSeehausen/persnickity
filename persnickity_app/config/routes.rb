Rails.application.routes.draw do
  resources :restaurants
  resources :accounts
  root 'sessions#new', as: 'login'
  post '/' => 'sessions#create'
  delete '/' => 'sessions#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
