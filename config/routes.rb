ProjetoFinal::Application.routes.draw do
    
    resources :degrees, only: [:new, :create, :destroy]
    resources :awards, only: [:new, :create, :destroy]
    resources :orientations, only: [:new, :create, :destroy]
    resources :extension_activities, only: [:new, :create, :destroy]
    resources :administrative_activities, only: [:new, :create, :destroy]
    resources :event_participations, only: [:new, :create, :destroy]
    resources :researches, only: [:new, :create, :destroy]
    resources :publications, only: [:new, :create, :destroy]
    resources :examining_boards, only: [:new, :create, :destroy]

    resources :kudos, only: [:create, :destroy]

    resources :relationships, only: [:create, :destroy] 

    resources :users do
		member do
			get :following, :followers, :htmlpage
		end
	end

    match '/signup', to: 'users#new'
    match '/signin', to: 'sessions#new'
    resources :sessions, only: [:new, :create, :destroy]
    match '/signout', to: 'sessions#destroy', via: :delete

    root to: 'static_pages#home'
    
	match '/contact', to: 'static_pages#contact'


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
