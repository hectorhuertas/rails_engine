Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get "/merchants/random", to: "merchant_searchs#show"
      get "/merchants/find", to: "merchant_searchs#show"
      get "/merchants/find_all", to: "merchant_searchs#index"
      resources :merchants, only: [:index, :show]

      get "/customers/random", to: "customer_searchs#show"
      get "/customers/find", to: "customer_searchs#show"
      get "/customers/find_all", to: "customer_searchs#index"
      resources :customers, only: [:index, :show]

      resources :items, only: [:index, :show] do
        collection do
          get "/find",     to: "items/search#show"
          get "/find_all", to: "items/search#index"
          get "/random",   to: "items/random#show"
        end
      end

      resources :invoices, only: [:index, :show] do
        collection do
          get "/find",     to: "invoices/search#show"
          get "/find_all", to: "invoices/search#index"
          get "/random",   to: "invoices/random#show"
        end
      end
    end
  end
end
