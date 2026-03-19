Rails.application.routes.draw do
  root to: "admin/dashboard#index"

  # Namespaces
  namespace :employee do
    get "dashboard/index"
  end

  namespace :manager do
    get "dashboard/index"
  end

  namespace :admin do
    root "dashboard#index"
    resources :companies do
      get :sectors, on: :member
      resources :sectors, shallow: true
      resources :users, only: [:index, :new, :create, :edit, :update, :destroy], shallow: true
    end
  end

 

  # Devise users
   devise_for :users, skip: [:registrations]

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check
end