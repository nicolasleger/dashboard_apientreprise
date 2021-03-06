Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'dashboard#index'

  get "/ping" => "ping#index", :constraints => {:ip => /127.0.0.1/}

  namespace 'api' do
    namespace 'uptime' do
      get 'all'
      get 'acoss'
      get 'infogreffe'
      get 'insee'
      get 'apientreprise'
      get 'qualibat'
      get 'taux_dispo'
    end

    namespace 'elasticsearch' do
      get 'requests_last_hour'
      get 'last_requests'
      get 'last_30_days_requests'
    end

    namespace 'stats' do
      namespace 'apientreprise' do
        get 'requests_last_hour' => 'elasticsearch#requests_last_hour'
        get 'last_requests' => 'elasticsearch#last_requests'
        get 'last_30_days_requests' => 'elasticsearch#last_30_days_requests'
      end

      namespace 'mps' do
        resources 'dossiers', only: [:index]
      end

      namespace 'tps' do
        resources 'dossiers', only: [:index]
      end
    end
  end

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
