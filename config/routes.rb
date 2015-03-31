Rails.application.routes.draw do
  use_doorkeeper scope: 'oauth'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  require 'sidekiq/web'
  require 'admin_constraint'
  mount Sidekiq::Web => '/sidekiq',constraints: AdminConstraint.new

  resources :sessions, only: [:new, :create, :destroy]
  resources :registrations, only: [:new, :create]

  root 'pages#home'

  get '/home' => 'pages#home'

  get 'oauth2/sign_in' => 'sessions#new', as: :oauth2_sign_in

  get 'sign_in' => 'sessions#new'
  get 'sign_in_fb' => 'sessions#create_with_fb'
  get 'sign_in_fb_m' => 'sessions#create_with_fb_m'

  get 'sign_up' => 'registrations#new'
  get 'sign_up_fb' => 'registrations#create_with_fb'
  get 'sign_up_fb_m' => 'registrations#create_with_fb_m'

  delete 'sign_out' => 'sessions#destroy'
  get '/forgot-password' => 'passwords#new', as: :forgot_password

  namespace :api do #, path: '/', constraints: {subdomain: 'api'} do
    namespace :v1 do
      get 'me' => 'credentials#me'
      resources :profiles
    end
  end

  namespace :admin do
    root 'users#index'
    resources :users
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
