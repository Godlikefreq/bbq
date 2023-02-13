require "resque_web"

Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  mount ResqueWeb::Engine => "/resque_web"

  root "events#index"

  resources :events do
    resources :comments, only: %i[ create destroy ]
    resources :subscriptions, only: %i[ create destroy ]
    resources :photos, only: %i[ create destroy ]

    post :show, on: :member
  end

  resources :users, only: %i[ show edit update]
end
