Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :cards, only: [:index]
      resources :user_cards, only: [:update]
      resources :users, only: [:create]
    end
  end
end
