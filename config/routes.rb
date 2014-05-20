GroceryWrangler::Application.routes.draw do
  get "modal/category_selection"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'users#index'

  resources :users, only: [:create, :index, :new]
  resources :store_items, only: [:create, :new, :show]
  resources :sessions, only: [:create]
  resources :receipt_items, only: [:destroy]
  resources :receipts
  resources :categories

  match '/signup',  to: 'users#new',        via: 'get'
  match '/signin',  to: 'sessions#new',     via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'

  match '/budgeting',    to: 'budgeting#index',                          via: 'get'
  match '/price_trend',   to: 'price_trend#index',                       via: 'get'
  match '/recipes', to: 'recipe#index',                                  via: 'get'
  match '/category_selection_dialog', to: 'categories#selection_dialog', via: 'get'

  match '/receipt_add_items', to: 'receipts#add_items', via: 'post'
  match '/receipt_items_selection_dialog', to: 'receipt_items#selection_dialog', via: 'get'
  match '/receipt_items', to: 'receipt_items#update', via: 'patch'
end
