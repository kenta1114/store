Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token

  resources :products do
    resources :subscribers, only: [:create]
  end

  # Cart routes
  resource :cart, only: [:show] do
    post :add_item
    delete :remove_item
    patch :update_quantity
  end

  root "products#index"
  
  # Health check endpoint
  get "up" => "rails/health#show", as: :rails_health_check

  # PWA routes (if needed)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end
end

