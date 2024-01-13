Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root "pages#show"
  get '/away', to: "pages#show"
  get '/my_portfolio', to: 'users#my_portfolio'
  get 'search_stock_js', to: 'stocks#search_stock'
  get 'search', to: 'stocks#search'
end
