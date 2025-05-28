Rails.application.routes.draw do
  get "sessions/new"
  get "sessions/create"
  get "sessions/destroy"
  root "pages#home"

  resources :users, only: [:new, :create, :show, :edit, :update]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'discover', to: 'users#discover', as: :discover

  resources :users, only: [:new, :create, :show, :edit, :update] do
    resources :posts, only: [:index], controller: 'user_posts'
    resources :user_tokens, except: [:show]
    resources :notifications, only: [:index, :show]
  end

  resources :posts do
    resources :images
    resources :comments, only: [:edit, :update, :create, :new, :destroy]
    resources :likes, only: [:create, :destroy]
    resources :post_hashtags, only: [:create, :destroy]
  end

  resources :hashtags
  resources :notifications
  resources :activity_histories, only: [:index, :show, :destroy]

  post 'notifications/mark_all_as_read', to: 'notifications#mark_all_as_read', as: :mark_all_as_read_notifications
  post 'notifications/:id/mark_as_read', to: 'notifications#mark_as_read', as: :mark_as_read_notification

  resources :chats, only: [:index, :show]
  post 'send_message', to: 'chats#create'
  
  resources :reports, only: [:index, :show, :new, :create, :destroy]
  resources :followers, only: [:create, :destroy]

  get 'dashboard', to: 'pages#dashboard', as: :dashboard
  get 'main', to: 'pages#main', as: :main

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