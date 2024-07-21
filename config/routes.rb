Rails.application.routes.draw do
  devise_for :users
  root 'pages#pre_home'

  resources :chatrooms, only: [:index, :show, :new, :create, :destroy] do
    resources :messages, only: [:create, :destroy]
    collection do
      get 'search', to: 'chatrooms#search'
    end
  end

  resources :friendships, only: [:create, :destroy]

  get 'users/profile', to: 'users#profile'
  get 'chat', to: 'chatrooms#index'
  get 'feed', to: 'pages#home'
  get 'users/friendlist', to: 'users#_friend_list'

  # User Settings
  get 'users/settings', to: 'settings#view'
  patch 'users/settings/update_profile_picture', to: 'settings#update_profile_picture'
  patch 'users/settings/update_username', to: 'settings#update_username'
  patch 'users/settings/update_email', to: 'settings#update_email'
  patch 'users/settings/update_password', to: 'settings#update_password'
end
