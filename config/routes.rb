Rails.application.routes.draw do
  devise_for :users
  root to: "static_pages#index"

  namespace :admins do
    root to: "categories#index"
    resources :categories
  end

  namespace :morderators do

  end

  namespace :authors do
    root to: "posts#index"
  end
end
