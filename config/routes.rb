Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :users, only: [:create] do
        resources :scores, only: [:create, :index]
        resources :cards, only: [:index]
      end
      resources :user_cards, only: [:update]
    end
  end
end
