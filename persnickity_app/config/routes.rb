Rails.application.routes.draw do
  resources :neighborhoods
  resources :boroughs
  resources :restaurants
  resources :accounts
  get '/' => 'static#new', as: 'homepage'
  get '/aboutus' => 'static#aboutus', as: 'aboutus'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
