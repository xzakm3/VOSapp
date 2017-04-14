Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #PAGES
  root 'static_pages#home'
  get  '/signup',  to: 'users#new'

  #POST REQUESTS
  post '/signup',  to: 'users#create'

  #RESOURCES
  resources :users

end
