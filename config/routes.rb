Rails.application.routes.draw do
  root 'pages#about'
  get '/form', to: 'pages#about'
  

  resources :pages , only: [:show,:index]

  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'   
  } 

  devise_scope :user do
    get "sign_in", :to => "users/sessions#new"
    get "sign_out", :to => "users/sessions#destroy" 
  end

  resources :books, only: [:new,:create,:show]
  post 'book_search', to: 'books#index'
  get 'book_search', to: 'books#index'

  resources :emotions, only: [:index,:edit,:update,:destroy,:new,:create]
  post 'emotion_write', to: 'emotions#new'

  resources :users, only: [:show]

  resources :reads, only: [:index]

  resources :users do
    resources :relationships, onry: [:create, :destroy]
    get :follows, on: :member
    get :followers, on: :member
  end

  get 'emotion_write', to: 'emotions#new'

  resources :maps, only: [:index,:create,:destroy]
  resources :nices, onry: [:create]

  namespace :api, format: 'json' do
    resources :emotions, only: [:create,:index]
    resources :reads, only: [:create,:index]
  end
end
