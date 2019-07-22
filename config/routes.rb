Rails.application.routes.draw do
  root 'categories#index'
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get '/login',   to: 'sessions#new'
  post '/login',   to: 'sessions#create'
  get 'auth/:provider/callback',   to: 'sessions#sociallogin', as: 'social_login'
  delete '/logout',  to: 'sessions#destroy'

  resources :users, except: [:destroy, :index] do
    resources :posts, except: :index  do
      resources :assets
    end
  end

  resources :conversations, only: [:create, :index] do
    resources :messages, only: [:new, :create, :index] 
  end

  resources :categories, only: [:index, :show]
  
  namespace :admin do
    resources :categories, except: [:index, :show]
  end

end
