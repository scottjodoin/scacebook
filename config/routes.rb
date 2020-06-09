Rails.application.routes.draw do

  devise_for :users, controllers: { :registrations => 'users/registrations', omniauth_callbacks: 'users/omniauth_callbacks' } do
    delete 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end
  # TODO: Consider using the "shallow" option for :pictures / :statuses
  resources :users, only: [:show, :index, :destroy] do
    resources :pictures
    resources :statuses
    resources :posts, only: [:show, :edit, :new, :destroy, :index]
  end
  resources :posts, only: [:show, :edit, :new, :destroy, :index]
  resources :pictures
  resources :statuses
  
  resources :friendships, only: [:index] do
    post :send_request, on: :collection
    post :accept_request, on: :collection
    post :unfriend, on: :collection
  end
  root to: "users#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
