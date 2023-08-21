Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "articles#index"

  get 'post/:slug', to: 'articles#show', as: :post
  resources :articles

  resources :categories
end
