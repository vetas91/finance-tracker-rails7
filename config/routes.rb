Rails.application.routes.draw do

  resources :user_stocks, only: [:create, :destroy]
  resources :friendships, only: [:create, :destroy]
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root "pages#show"
  get '/away', to: "pages#show"
  get '/my_portfolio', to: 'users#my_portfolio'
  get '/my_friends', to: 'users#my_friends'
  get 'search_stock_js', to: 'stocks#search_stock'
  get 'search', to: 'stocks#search'
  post 'search', to: 'stocks#search'
  get 'search_user', to: 'users#search'
  resources :users, only: [:show]
end
