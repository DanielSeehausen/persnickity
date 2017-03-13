Rails.application.routes.draw do
  resources :neighborhoods, :boroughs, :restaurants, :accounts

  get    '/'        => 'static#new',     as: 'home'
  post   '/'        => 'sessions#create' 
  delete '/'        => 'sessions#destroy'
  get    '/aboutus' => 'static#aboutus', as: 'aboutus'
end
