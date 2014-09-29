Rails.application.routes.draw do
  resources :events

  devise_for :users
  resources :recipes
  get "tags/:tag", to: "events#index", as: :tag
end
