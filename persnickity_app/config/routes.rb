Rails.application.routes.draw do
  resources :neighborhoods, :boroughs, :restaurants, :accounts
  get '/' => 'static#new', as: 'homepage'
  get '/login' => 'static#login' #has to be changed to sessions once we merge
  get '/about' => 'static#about', as: 'about'
  get '/contact' => 'static#contact', as: 'contact'
end
