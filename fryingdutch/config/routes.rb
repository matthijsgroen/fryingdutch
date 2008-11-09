ActionController::Routing::Routes.draw do |map|
  map.resources :games, :member => { :info => :get } do |game|
    game.set_rating 'rating', :controller => "Games", :action => "rating", :requirements => { :method => :put }
    game.resources :comments, :controller => "Games::Comments"
    game.resources :screenshots, :controller => "Games::Screenshots"
    game.resources :usershots, :controller => "Games::Usershots"
  end
  map.games_by_tagname "games/tag/:tagname", :controller => "games", :action => "by_tagname"

  map.resources :users do |user|
    user.add_game 'add_game/:game_id', :controller => "users", :action => "add_game", :requirements => { :method => :post }
  end

  map.logoff 'logoff', :controller => "users", :action => "logoff"
  map.desktop 'desktop', :controller => "users", :action => "desktop"
  map.settings 'settings', :controller => "users", :action => "settings"
  
  map.open_id_complete 'sessions', :controller => "sessions", :action => "create", :requirements => { :method => :get }
  map.resources :sessions

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
