Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'user/registrations' }

  resources :user_stocks, except: [:index, :show, :edit, :update]

  resources :users, only: [:show]

  resources :friendships

  root 'welcome#index'

  get  'search_stocks',  to: 'stocks#search'
  get  'update_stocks',  to: 'stocks#update_stocks_prices'
  get  'my_portfolio',   to: 'users#my_portfolio'
  get  'my_friends',     to: 'users#my_friends'
  get  'search_friends', to: "users#search"
  post 'add_friend',     to: "users#add_friend"

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
