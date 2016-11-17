Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :items
  resources :item_users, only: [:create, :destroy]
  resources :expenses, only: [:create, :destroy]
  resources :expense_users, only: [:create, :destroy]
  resources :payments, only: [:create, :destroy]

  get 'home/index'
  root 'items#index'
end
