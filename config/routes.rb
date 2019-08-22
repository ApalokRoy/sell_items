Rails.application.routes.draw do
  root "categories#index"
  get "/signup",  to: "users#new"
  post "/signup",  to: "users#create"
  get "/login",   to: "sessions#new"
  post "/login",   to: "sessions#create"
  get "auth/:provider/callback",   to: "sessions#sociallogin", as: "social_login"
  delete "/logout",  to: "sessions#destroy"

  resources :users, except: [:destroy, :index] do
    resources :posts, except: :index  do
      get "sendmail", as: "send_mail", on: :member 
      get "myshow", as: "my_show", on: :member 
      get "myindex", as: "my_index", on: :collection
      
      resources :assets, only: :destroy
      resources :reviews, only: [:create, :destroy, :update, :edit] 
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
    get "/home",  to: "home#index"
    resources :categories
    resources :posts, only: [:show, :index] do
      get "pending", on: :collection 
      post "status", on: :member
    end
    resources :reviews, only: [:show, :index] do
      get "pending", on: :collection 
      post "status", on: :member
    end
  end

end
