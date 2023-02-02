Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :recipes, only: %i[index show] do
    member do
      post 'favorite', to: "recipes#favorite"
      post 'unfavorite', to: "recipes#unfavorite"
      post 'toggle_favorite', to: "recipes#toggle_favorite"
    end
  end

  resources :items
  resources :my_recipes
  get 'cookbook', to: 'pages#cookbook'
end
