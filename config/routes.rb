Rails.application.routes.draw do
  # devise_for :users
  post 'auth_user' => 'authentication#authenticate_user'
  resources :users, only: :create do
    get :create_by_provider, on: :collection
  end
  controller :home do
    get :index
    get :login
  end
  get 'auth/:provider/callback', to: 'users#create_by_provider'
  get 'auth/failure', to: redirect('/')
  root 'home#index'
  get '/api/:email/accounts', to: 'accounts#index'
  get '/api/:email/accounts/:provider', to: 'accounts#provider'
  get '/api/:email/connections', to: 'accounts#connections'
end
