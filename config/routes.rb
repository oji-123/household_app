Rails.application.routes.draw do
  devise_for :users
  root to: "payments#index"
  resources :payments, only: [:index, :new, :create, :edit, :update, :destroy] do
    collection do
      post 'follow'
    end
  end
end
