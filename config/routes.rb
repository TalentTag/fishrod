Rails.application.routes.draw do

  root to: "entries#index"

  resources :entries, only: %i(index show) do
    collection { get 'sources/(:source)' => 'entries#index', as: '' }
    member { post :reject }
  end

  namespace :stats do
  	get :entries
  end

end
