Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :users do
        resources :scores, only: [:create]
      end
      resources :cards, only: [:index]
      resources :user_cards, only: [:update]
      resources :users, only: [:create] do
        resources :cards, only: [:index]
      end
    end
  end
end
