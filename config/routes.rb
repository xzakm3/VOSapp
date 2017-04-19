Rails.application.routes.draw do
  get 'sessions/new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #PAGES
  root 'static_pages#home'
  get '/signup',  to: 'users#new'
  get '/login', to: 'sessions#new'

  #POST REQUESTS
  post '/signup',  to: 'users#create'
  post '/login', to: 'sessions#create'

  #DELETE
  delete '/logout', to: 'sessions#destroy'

  #RESOURCES
  resources :users
  resources :account_activations, only: :edit

end
