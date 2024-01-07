Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root "pages#show"
  get '/my_portfolio', to: 'users#my_portfolio'
  get 'search_stock', to: 'stocks#search'
end
