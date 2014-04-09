JoseCanseco::Application.routes.draw do
  get "modal/category_selection"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'users#index'

  resources :users
  resources :receipts
  resources :categories
  resources :receipt_items, only: [:destroy]
  resources :sessions, only: [:new, :create, :destroy]

  match '/signup',  to: 'users#new',         via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'

  match '/budgeting',    to: 'budgeting#index',    via: 'get'
  match '/price_trend',   to: 'price_trend#index',   via: 'get'
  match '/recipes', to: 'recipe#index', via: 'get'
  match '/category_selection_dialog', to: 'categories#selection_dialog', via: 'get'

  match '/receipt_add_items', to: 'receipts#add_items', via: 'post'

  match '/receipt_items_selection_dialog', to: 'receipt_items#selection_dialog', via: 'get'
  match '/receipt_items', to: 'receipt_items#update', via: 'patch'

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
