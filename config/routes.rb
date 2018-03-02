Rails.application.routes.draw do

  get 'braintree/new'

  get 'listings/all' => "listings#indexall"
  get 'reservations/all' => "reservations#index"

  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, only: [:create, :edit] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
    
  end
  
  resources :listings do
    collection  do
      get :a_title
      get :d_title
      get :a_price
      get :d_price
      get :city
    end
    resources :reservations do
      get 'braintree/new'
        post 'braintree/checkout'
    end
    resources :images
  end

  concern :paginatable do
  get '(page/:page)', action: :index, on: :collection, as: ''
  end

  resources :my_resources, concerns: :paginatable

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html.
  get "/search" => "welcome#index"
  post "/search" => "listings#search"

  # post 'braintree/checkout'

  get "/filter" => "listings#filter"
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"
  
  root "welcome#index"
end
