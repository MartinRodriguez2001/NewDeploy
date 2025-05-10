Rails.application.routes.draw do
  root "pages#home"

  resources :users do
    resources :user_tokens, except: [:show]
    resources :notifications, only: [:index, :show]
  end

  resources :posts do
    resources :images
    resources :comments
    resources :likes, only: [:create, :destroy]
    resources :post_hashtags, only: [:create, :destroy]
  end

  resources :hashtags
  resources :notifications
  resources :activity_histories, only: [:index, :show, :destroy]

  resources :chats do
    resources :messages, only: [:index, :show, :create, :destroy]
  end

  resources :reports, only: [:index, :show, :new, :create, :destroy]
  resources :followers, only: [:create, :destroy]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end