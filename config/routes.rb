Rails.application.routes.draw do
  devise_for :logins
  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    get 'sign_up', to: 'devise/registrations#new'
  end


  devise_for :logins, skip: :all
  root "users#index"
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :new, :show, :destroy] do
      resources :comments, only: [:new, :create, :destroy]
      resources :likes, only: [:create]
    end
  end
  post "users/:user_id/posts", to: "posts#create", as: :user_create_post

  namespace :api do
    namespace :v1 do
      resources :users do
        resources :posts, only: [:index] do
          resources :comments, only: [:index, :create]
        end
      end
    end
  end
end


