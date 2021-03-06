Domino::Application.routes.draw do

  #subdomaining for online games has to be implemented further
  #match '/' => 'domino/games#show', :constraints => { :subdomain => /.+/ }

  root :to => "visitor#welcome"

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  get "password_resets/new"

  get "chat/index"

  match 'auth/:provider/callback', to: 'facebook#create'
  match 'auth/failure', to: redirect('/')

  match '/login' => 'visitor#login', :as => :login
  match '/register' => 'visitor#register', :as => :register
  match '/logout' => 'dd#logout', :as => :logout

  match '/dd' => 'dd#index', :as => :dd_index

  match '/set_localization/(:locale)' => 'visitor#set_localization', as: :set_localization

  resources :visitor do
    collection do
      get :about
      post :do_login
      post :process_register
      get :create_guest
      get :forgot
      get 'activate/(:token)' => 'visitor#activate', as: :activate
    end
  end

  resources :password_resets

  resources :translations

  namespace :dd do
    resources :users do
      collection do
        get :index
        get :show
      end
    end

    resources :friendships

    resources :dashboard do
      collection do
        post :create_post
        post :create_comment
        get 'like_post/(:id)' => 'dashboard#like_post', as: :like_post
        get 'dislike_post/(:id)' => 'dashboard#dislike_post', as: :dislike_post
        get 'like_comment/(:id)' => 'dashboard#like_comment', as: :like_comment
        get 'dislike_comment/(:id)' => 'dashboard#dislike_comment', as: :dislike_comment
        get 'show_more/(:id)' => 'dashboard#show_more', as: :show_more
      end
    end

    resources :clans

    resources :games do
      collection do
        get :index
        get :show
        get :update
        post :find
        get 'handle_move/(:id)' => 'games#handle_move', :as => :handle_move
        get 'take_from_market/(:id)' => 'games#take_from_market', :as => :take_from_market
      end
    end

    resources :chat do
      collection do
        get :index
      end
    end

  end

  # match '/admin' => 'admin#index', :as => :admin_index
  #namespace :admin do
  #
  #  resources :users
  #
  #
  #end



  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
