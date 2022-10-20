Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :transactions, only: [:index, :create, :update]
    end
  end

  # get '/api/v1/transactions/spend', to: 'api/v1/transactions#spend'

end
