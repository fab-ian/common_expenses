Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :items
  resources :item_users, only: [:create, :destroy]

  get 'home/index'
  root 'items#index'
end
