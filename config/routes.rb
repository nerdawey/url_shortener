Rails.application.routes.draw do
  resources :urls, param: :short_code, only: [:create, :show, :update, :destroy] do
    member do
      get 'stats'
    end
  end
end