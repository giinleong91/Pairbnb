Rails.application.routes.draw do
  get 'reservations/new'

  get 'reservations/create'

  get 'reservations/index'

  resources :reservations

  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, only: [:create, :edit] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
    
  end
  
  resources :listings

  concern :paginatable do
  get '(page/:page)', action: :index, on: :collection, as: ''
  end

  resources :my_resources, concerns: :paginatable

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "/search" => "listings#search"
  get "/filter" => "listings#filter"
  post "/cart" => "listings#cart"
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"
  
  root "welcome#index"
end
