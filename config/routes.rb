Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :accounts, only: [:show, :index] do
        collection do
          get 'accounts', to: 'accounts#index'
          get 'accounts/:id', to: 'accounts#show'
        end
      end

      resources :funds_transfer
    end
  end
end
