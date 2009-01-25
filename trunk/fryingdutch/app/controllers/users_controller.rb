class UsersController < ApplicationController
  
  before_filter :login_required, :only => [:desktop, :settings, :add_game, :remove_game]
  
  # GET /users
  # GET /users.xml
  def index
    @users = User.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end
  
  def desktop
  end
  
  def settings
    @token_url = add_token_url(:add => current_user.id)
  end
  
  def new
    # new.html.erb, registration page    
  end
  
  def edit
    
  end
  
  def add_game
    game = Game.find_by_permalink(params[:game_id])
    
    respond_to do |format|
        format.js do
          if current_user.plays game
            render :update do |page|
              page["#game_#{game.id}"].add_class "personal"

              page["#game_#{game.id} .play_options"].replace_html :partial => 'games/play_options', 
                :locals => { :game => game }
              page << "jQuery.facebox({ ajax: '/game-support/#{game.permalink}/collect-info' })" if game.extra_support? and game.support.features[:collect_info?]
            end
          end
        end        
    end  
  end

  def remove_game
    @game = Game.find_by_permalink(params[:game_id])
    @user_game = current_user.user_games_playing.find_by_game_id(@game.id)
    @user_game.end_date = Date.today
    @user_game.save
    
    @quit_reasons = [
      ["Saai", 
        "het spel saai was geworden", "boring"],
      ["Tijds intensief", 
        "het spel teveel tijd in beslag nam", "time-consuming"],
      ["Te duur", 
        "het spel kost me te veel geld", "money-consuming"],
      ["Zelf geen tijd", 
        "ik geen tijd meer had om te spelen", "no-time"],
      ["Ander spel", 
        "ik een ander spel leuker vind", "another-game"],
      ["Spel is veranderd", 
        "het spel veranderd is in negatieve zin", "game-changed"],
      ["Geen leuke sfeer", 
        "andere spelers verpesten de sfeer", "other-players"],
      ["TFD Support", 
        "handige tools zijn hier niet, en dat heeft het een beetje verpest voor mij", "tfd-support"]
    ]
    #TODO: sort this in the way the people vote for this game?
    respond_to do |format|
      format.js do
        render_to_facebox :partial => "games/quit_reasons" do |page|
          page["#game_#{@game.id}"].remove_class "personal"
          page["#game_#{@game.id} .play_options"].replace_html :partial => 'games/play_options', 
            :locals => { :game => @game }
        end            
      end        
    end  
  end
  
  def add_friend
    @user = User.find_by_permalink(params[:user_id])
    current_user.watch @user unless current_user.watching? @user
    
    respond_to do |format|
      format.js {
        render :update do |page|
          page["#friend_status"].replace_html :text => \
            link_to_remote("Verwijderen als vriend", :url => user_remove_buddy_path(@user), :method => :put)
          page["#friend_status"].highlight
        end
      }      
      #format.html { redirect_to @user }
    end
  end

  
  def remove_friend
    @user = User.find_by_permalink(params[:user_id])
    current_user.unwatch @user if current_user.watching? @user
    
    respond_to do |format|
      format.js {
        render :update do |page|
          page["#friend_status"].replace_html :text => \
            link_to_remote("Als vriend toevoegen", :url => user_add_buddy_path(@user), :method => :put)
          page["#friend_status"].highlight
        end
      }      
      #format.html { redirect_to @user }
    end
  end


  def update_quit_reason
    quit_entry = current_user.user_games.find params[:reason_id]
    quit_entry.update_attributes params[:user_game]
    
    respond_to do |format|
      format.js { close_facebox }
    end
  end

  def logoff
    reset_session
    redirect_to root_url
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find_by_permalink(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
end
