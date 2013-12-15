Wiki::Application.routes.draw do
  get "users/show"
  get "users/create"
  get "users/destroy"
  get "users/index"
  get "users/new"


  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  
  root "static_pages#index"
  
  #Users
  get "signup" => "users#new", :as => "signup"
  get "signin" => "sessions#new", :as => "signin"
  delete "signout" => "sessions#destroy", :as => "signout"
end
