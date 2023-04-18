Rails.application.routes.draw do
  resources :boards do
    resources :columns do
      resources :stories
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
