Rails.application.routes.draw do
  get 'sessions/new'

  root 'welcome#index'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get  '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users do
    get 'change_password'
    post 'change_password'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
