Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :accounts, only: [:show, :index, :create] do
        collection do
          get 'accounts', to: 'accounts#index'
          get 'accounts/:id', to: 'accounts#show'
          post 'accounts', to: 'accounts#create'
        end
      end

      resources :funds_transfer
    end
  end
end
