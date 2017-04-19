Rails.application.routes.draw do
  # devise_for :users
  post 'auth_user' => 'authentication#authenticate_user'
  resources :users, only: :create
  controller :home do
    get :index
    get :login
  end
  get '/auth/twitter/callback' => 'home#index'
  get '/auth/facebook/callback' => 'home#index'
  root 'home#index'
end
