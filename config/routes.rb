Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "/merchants/random", to: "merchant_searchs#show"
      get "/merchants/find", to: "merchant_searchs#show"
      get "/merchants/find_all", to: "merchant_searchs#index"
      resources :merchants, only: [:index, :show]
    end
  end
end
