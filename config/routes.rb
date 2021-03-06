Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get "/merchants/random",   to: "merchant_searchs#show"
      get "/merchants/find",     to: "merchant_searchs#show"
      get "/merchants/find_all", to: "merchant_searchs#index"

      resources :merchants, only: [:index, :show] do
        collection do
          get "/most_revenue", to: "merchants/revenue#index"
        end
        get "revenue", to: "merchants/revenue#show"
        get "favorite_customer", to: "merchants/favorite_customer#show"
        get "customers_with_pending_invoices", to: "merchants/customers_with_pending_invoices#index"
        resources :items,    module: :merchants, only: [:index]
        resources :invoices, module: :merchants, only: [:index]
        # resources :most_revenue, module: :merchants, only: [:index]
      end

      get "/customers/random",   to: "customer_searchs#show"
      get "/customers/find",     to: "customer_searchs#show"
      get "/customers/find_all", to: "customer_searchs#index"
      resources :customers, only: [:index, :show] do
        get "favorite_merchant", to: "customers/favorite_merchant#show"
        resources :invoices,     module: :customers, only: [:index]
        resources :transactions, module: :customers, only: [:index]
      end

      resources :items, only: [:index, :show] do
        collection do
          get "/find",     to: "items/search#show"
          get "/find_all", to: "items/search#index"
          get "/random",   to: "items/random#show"
        end
        resources :invoice_items, module: :items, only: [:index]
        resource :merchant,       module: :items, only: [:show]
      end

      resources :invoices, only: [:index, :show] do
        collection do
          get "/find",     to: "invoices/search#show"
          get "/find_all", to: "invoices/search#index"
          get "/random",   to: "invoices/random#show"
        end
        resources :transactions,  module: :invoices, only: [:index]
        resources :invoice_items, module: :invoices, only: [:index]
        resources :items,         module: :invoices, only: [:index]
        resource :customer,       module: :invoices, only: [:show]
        resource :merchant,       module: :invoices, only: [:show]
      end

      resources :invoice_items, only: [:index, :show] do
        collection do
          get "/find",     to: "invoice_items/search#show"
          get "/find_all", to: "invoice_items/search#index"
          get "/random",   to: "invoice_items/random#show"
        end
        resource :invoice, module: :invoice_items, only: [:show]
        resource :item,    module: :invoice_items, only: [:show]
      end

      resources :transactions, only: [:index, :show] do
        collection do
          get "/find",     to: "transactions/search#show"
          get "/find_all", to: "transactions/search#index"
          get "/random",   to: "transactions/random#show"
        end
        resource :invoice, module: :transactions, only: [:show]
      end
    end
  end
end
