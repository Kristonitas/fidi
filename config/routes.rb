Rails.application.routes.draw do

  devise_for :fidders
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: 'application#info'

  apipie
  # Routes for fidi men
  get 'attempt_for/:id' => 'attempts#new'

  post 'attempts' => 'attempts#create'

  # Need fallback and admin login routes

  # Routes for apps

  # Route to get initial data unrelated to user
  get 'info' => 'application#info'
  # Might need a route to get all of data for user
  ###
  # Route to create a new user
  post 'users' => 'users#create'
  post 'users/login' => 'users#login'

  # Route to show or refresh global leaderboard
  get 'users/leaderboard' => 'users#leaderboard', as: 'leaderboard'
  get 'users/:id/leaderboard' => 'users#leaderboard', as: 'user_leaderboard'
  # Route to show or refresh user and his stats
  get 'users/:id' => 'users#show', as: 'user'

  # Route to show or refresh booth and booth leaderboard
  get 'booths/:id' => 'booths#show', as: 'booth'
  # Route to fetch the whole map with booths and their positions
  get 'booths/map' => 'booths#map', as: 'map'


  get 'posts' => 'posts#index', as: 'posts'

  get 'posts/:id' => 'posts#show', as: 'post'

  # resources :users

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
