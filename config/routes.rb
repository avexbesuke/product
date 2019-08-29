Rails.application.routes.draw do
  root 'pages#about'

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

  resources :emotions, only: [:new,:create]
  post 'emotion_write', to: 'emotions#new'

  resources :users, only: [:show]

  resources :reads, only: [:create,:index]
end
