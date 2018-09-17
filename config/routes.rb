Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :users, only: [:create] do
        resources :scores, only: [:create, :index]
        resources :cards, only: [:index, :update]
      end
    end
  end
end
