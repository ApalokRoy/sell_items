Rails.application.routes.draw do
  root 'static_pages#home'
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get '/login',   to: 'sessions#new'
  post '/login',   to: 'sessions#create'
  get 'auth/:provider/callback',   to: 'sessions#sociallogin', as: 'social_login'
  delete '/logout',  to: 'sessions#destroy'

  resources :users

end
