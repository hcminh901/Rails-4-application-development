Rails.application.routes.draw do
  root to: "events#index"
  resources :events
  resources :pins
  resources :boards
  devise_for :users
  resources :recipes
  get "tags/:tag", to: "events#index", as: :tag

  resources :events do
    get :join, to: "events#join", as: :join
    get :accept_request, to: "events#accept_request", as: :accept_request
    get :reject_request, to: "events#reject_request", as: :reject_request
  end

  get :my_events, to: "events#my_events", as: :my_events
end
