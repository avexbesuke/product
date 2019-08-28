Rails.application.routes.draw do
  get 'emotions/create'
  get 'books/index'
  root 'pages#index'

  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'   
  } 

  devise_scope :user do
    get "sign_in", :to => "users/sessions#new"
    get "sign_out", :to => "users/sessions#destroy" 
  end

  resources :books, only: [:new,:create]
  post 'book_search', to: 'books#index'

end
