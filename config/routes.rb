Rails.application.routes.draw do
  devise_for :users

  resources :boards do
    resources :columns do
      resources :stories
    end
  end

  get '/users/:id', to: 'users#show'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: "boards#index"
  # Defines the root path route ("/")
  # root "articles#index"
end
