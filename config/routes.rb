Rails.application.routes.draw do
  resources :categories
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")

  unauthenticated do
    root to: "pages#home", as: :unauthenticated_root
  end

  authenticated do
    root to: "discussions#index"
  end

  resources :discussions do
    resources :posts, only: [:create, :show, :edit, :update, :destroy], module: :discussions

    collection do
      get 'category/:id', to: "categories/discussions#index", as: :category
    end

    resources :notifications, only: :create, module: :discussions
  end

  resources :notifications, only: :index do
    collection do
      post '/mark_as_read', to: "notifications#read_all", as: :read
    end
  end

  mount MissionControl::Jobs::Engine, at: "/jobs"
end
