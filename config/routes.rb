Rails.application.routes.draw do
  namespace :admin do
  get 'dashboard/index'
  end

  root to: "events#my_events"
  resources :articles

  resources :site_details

  mount Ckeditor::Engine => "/ckeditor"
  get "pages/home_page"

  namespace :admin do
  get "dashboard/index"
  end

  resources :menus

  resources :restaurants do
    collection do
      get "export_menus"
    end
  end

  get "home/index"

  resources :events
  resources :pins
  resources :boards
  devise_for :users, controllers: {registrations: "registrations"}
  resources :recipes
  get "tags/:tag", to: "events#index", as: :tag

  resources :events do
    get :join, to: "events#join", as: :join
    get :accept_request, to: "events#accept_request", as: :accept_request
    get :reject_request, to: "events#reject_request", as: :reject_request
  end

  get :my_events, to: "events#my_events", as: :my_events
  get :search, to: "home#search", as: :search
  post "pin_post/:id", to: "pins#pin_post", as: :pin_post
  resources :setup_organization

  authenticated do
    get "/", to: "dashboard#show",
      constraints: Subdomain, as: :dashboard
  end

  namespace :admin do
    get "", to: "dashboard#index", as: "/"
  end
end
