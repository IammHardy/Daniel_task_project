Rails.application.routes.draw do

  # Devise routes for users
  devise_for :users



  namespace :admin do
  resources :companies do
    resources :sectors
    resources :users
  end
  resources :tasks
  root "dashboard#index"
end

  # Manager namespace
  namespace :manager do
    resources :tasks
    root "dashboard#index", as: :dashboard
  end

  # Employee namespace
  namespace :employee do
    resources :tasks, only: [:index, :show]
    root "dashboard#index", as: :dashboard
  end

  # Role-aware root path
  authenticated :user do
    root to: "home#redirect_by_role", as: :authenticated_root
  end

  # Default root for guests
  root "home#index"
end