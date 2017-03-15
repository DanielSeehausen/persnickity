Rails.application.routes.draw do
  resources :neighborhoods, :boroughs, :restaurants, only: [:index, :show]
  resources :accounts, except: [:index]
  get '/' => 'static#new', as: 'homepage'
  get '/login' => 'sessions#new' #has to be changed to sessions once we merge
  post '/login' => 'sessions#create'
  get '/about' => 'static#about', as: 'about'
  get '/contact' => 'static#contact', as: 'contact'
  delete '/' => 'sessions#destroy', as: 'logout'

  #wildcard catch for anything and everything that has fallen through
  get "*a", :to => 'application#not_found'

end
