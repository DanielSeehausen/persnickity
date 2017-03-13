Rails.application.routes.draw do
  resources :neighborhoods
  resources :boroughs
  resources :restaurants
  resources :accounts
  get '/' => 'static#new', as: 'homepage'
  get '/login' => 'static#login' #has to be changed to sessions once we merge
  get '/about' => 'static#about', as: 'about'
  get '/contact' => 'static#contact', as: 'contact'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
