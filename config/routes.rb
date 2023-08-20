Rails.application.routes.draw do
  get ':slug', to: 'articles#show', as: :news
  resources :articles
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "articles#index"
end
