Rails.application.routes.draw do
  root 'pages#index'
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  
  devise_scope :user do
    get "sign_in", :to => "users/sessions#new"
    get "sign_out", :to => "users/sessions#destroy" 
  end

end
