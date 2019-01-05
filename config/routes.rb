Rails.application.routes.draw do
  devise_for :users

  root to: "static_pages#index"

  namespace :admins do
    root to: "dashboards#index"
    resources :categories
    resources :topics
    resources :posts, only: %i(index new show update destroy)
    resources :morderators, only: %i(index show create destroy)
    resources :users
    get "add_or_minus_moderators/:user_id/category/:id", to: "categories#add_or_minus_morderator", as: "add_or_minus_morderator"
    get "ban_or_unban_authors/:user_id/category/:id", to: "categories#ban_or_unban_authors", as: "ban_or_unban_author"
    get "ban_or_unban_authors/:user_id/topic/:id", to: "topics#ban_or_unban_authors", as: "ban_or_unban_author_topic"
  end

  namespace :morderators do

  end

  namespace :authors do
    root to: "posts#index"
  end
end
