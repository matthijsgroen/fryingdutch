ActionController::Routing::Routes.draw do |map|
  
  map.resources :messages
  
  map.resources :boards do |board|
    board.add 'add', :controller => "Boards", :action => "add_board", :requirements => { :method => :get }
    #topics
    board.resources :discussion_topics, :as => "disc", :controller => "Boards::DiscussionTopics"

    #reactions
    board.resources :text_reactions, :as => "text", :controller => "Boards::TextReactions", :path_prefix => "/boards/:board_id/t/:topic_id" 
  end

  map.resources :games do |game|
    game.set_rating 'rating', :controller => "Games", :action => "rating", :requirements => { :method => :put }
    game.quit_reason 'quit/:reason_id', :controller => "Users", :action => "update_quit_reason", :requirements => { :method => :put } 
    game.resources :comments, :controller => "Games::Comments"
    game.resources :screenshots, :controller => "Games::Screenshots" do |shot|
      shot.resources :comments, :controller => "Games::ScreenshotComments"
    end
    game.resources :usershots, :controller => "Games::Usershots"
    game.resource :metadata, :controller => "Games::Metadatas"
  end
  map.games_by_tagname "games/tag/:tagname", :controller => "games", :action => "by_tagname"

  map.resources :users, :collection => { :register => :get } do |user|
    user.add_game 'add_game/:game_id', :controller => "users", :action => "add_game", :requirements => { :method => :put }
    user.remove_game 'remove_game/:game_id', :controller => "users", :action => "remove_game", :requirements => { :method => :put }
    user.add_buddy 'add_buddy', :controller => "users", :action => "add_friend", :requirements => { :method => :put }
    user.remove_buddy 'remove_buddy', :controller => "users", :action => "remove_friend", :requirements => { :method => :put }
  end
  map.check_nickname 'check_nickname', :controller => "users", :action => "check_nickname", :requirements => { :method => :get }
  map.finish_registration 'finish_registration', :controller => "users", :action => "finish_registration", :requirements => { :method => :post }
  
  # World of Warcraft
  map.with_options :path_prefix => "/game-support/world-of-warcraft", :controller => "GameSupport::WorldOfWarcraft" do |wow|
    wow.wow_collect_info 'collect-info', :action => "collect_info", :requirements => { :method => :get }
    wow.wow_update_characters 'characters', :action => "update_characters", :requirements => { :method => :put }
  end

  map.token 'rpx_token', :controller => "sessions", :action => "rpx_token_signin"
  map.add_token 'rpx_token/:add', :controller => "sessions", :action => "rpx_token_signin"
  map.logoff 'logoff', :controller => "users", :action => "logoff"
  map.desktop 'desktop', :controller => "users", :action => "desktop"
  map.settings 'settings', :controller => "users", :action => "settings"
  
  map.open_id_complete 'sessions', :controller => "sessions", :action => "create", :requirements => { :method => :get }
  map.resources :sessions
  
  map.search 'search', :controller => "search", :action => "search", :requirements => { :method => :post }

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
