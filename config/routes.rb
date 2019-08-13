Rails.application.routes.draw do
  root "categories#index"
  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  get "/signup",  to: "users#new"
  post "/signup",  to: "users#create"
  get "/login",   to: "sessions#new"
  post "/login",   to: "sessions#create"
  get "auth/:provider/callback",   to: "sessions#sociallogin", as: "social_login"
  delete "/logout",  to: "sessions#destroy"

  resources :users, except: [:destroy, :index] do
    resources :posts, except: :index  do
      get "sendmail", as: "send_mail", on: :member 
      
      resources :assets, only: :destroy
      resources :reviews, only: [:create, :destroy] 
    end
  end

  resources :conversations, only: :index do
    get "find_or_create", on: :collection
    resources :messages, only: [:new, :create, :index] 
  end

  resources :categories, only: [:index, :show]
  
  resources :posts, only: [] do
    get "search" , on: :collection
  end

  namespace :admin do
    resources :categories, except: [:index, :show]
    resources :posts, only: [] do
      get "pending", on: :collection 
      post "status", on: :member
    end
    resources :reviews, only: [] do
      get "pending", on: :collection 
      post "status", on: :member
    end

  end

end
