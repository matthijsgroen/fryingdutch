class UsersController < ApplicationController
  
  before_filter :login_required, :except => [:new, :show]
  
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
  end
  
  def new
    # new.html.erb, registration page    
  end
  
  def add_game
    game = Game.find_by_permalink(params[:game_id])
    
    respond_to do |format|
      if current_user.plays game 
        format.js do
          render :update do |page|
            page["#game_#{game.id} .play_options"].replace_html :partial => 'games/play_options', :locals => { :game => game }
            game.collect_info page
          end          
        end        
      end
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
