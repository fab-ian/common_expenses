Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :items do
    resources :expenses, only: :edit
  end
  resources :item_users, only: [:create, :destroy]
  resources :expenses, only: [:create, :update, :destroy]
  resources :expense_users, only: [:create, :destroy]
  resources :payments, only: [:create, :destroy]

  get(
    'calculators/calculate_amounts/:item_id' => 'calculators#calculate_amounts',
    as: 'calculate'
  )

  # authenticate :user, lambda { |u| u.admin? } do
  authenticate :user do
    mount Sidekiq::Web => '/sidekiq'
  end

  namespace :api do
    get 'users/:id/available_users_item' => 'users#available_users_item'
  end

  root 'items#index'
end
