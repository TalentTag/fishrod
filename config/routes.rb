Rails.application.routes.draw do

  root to: "entries#index"

  resources :entries, only: %i(index show) do
    member { post :reject }
  end

  namespace :stats do
  	get :entries
  end

  resources :searches, only: %i(index create update destroy)

end
