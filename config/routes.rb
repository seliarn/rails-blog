Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "application#index"

  get 'post/:slug', to: 'articles#show', as: :post
  get 'articles/', to: redirect('/')
  resources :articles

  resources :categories
end
