Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' } do
    delete 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end
  resources :users, only: [:show, :index]
  resources :friendships, only: [:index] do
    post :send_request, on: :collection
    post :accept_request, on: :collection
    post :unfriend, on: :collection
  end
  root to: "users#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
