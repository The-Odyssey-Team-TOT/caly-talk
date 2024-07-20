# config/routes.rb
Rails.application.routes.draw do
  get 'messages/create'
  devise_for :users
  root 'chatrooms#index'

  resources :chatrooms, only: [:index, :show, :new, :create] do
    resources :messages, only: [:create]
  end

  resources :friendships, only: [:create, :destroy]
  get 'search', to: 'chatrooms#search'
end
