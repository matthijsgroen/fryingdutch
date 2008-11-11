class GamesController < ApplicationController

  before_filter :login_required, :only => [:new, :create, :edit, :update, :destroy]
  
  # GET /games
  # GET /games.xml
  def index
    @games = Game.find :all
    @tags = Game.tag_counts :order => "name asc"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @games }
    end
  end

  def by_tagname
    @games = Game.find_tagged_with(params[:tagname], :match_all => true)

    respond_to do |format|
      format.html # by_tagname.html.erb
      format.xml  { render :xml => @games }
    end
  end

  # GET /games/1
  # GET /games/1.xml
  def show
    @game = Game.find_by_permalink(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.js { render :partial => "game", :object => @game }
      format.xml  { render :xml => @game }
    end
  end

  # GET /games/new
  # GET /games/new.xml
  def new
    @game = Game.new
    @game.name = "Nieuw spel" 

    respond_to do |format|
      format.html # new.html.erb
      format.js {
        render :update do |page|
          page['#add_game'].before render(:partial => "remote_form")
          page['#add_game'].hide
        end
      }
      format.xml  { render :xml => @game }
    end
  end

  # POST /games
  # POST /games.xml
  def create
    @game = Game.new(params[:game])

    respond_to do |format|
      if @game.save
        flash[:notice] = 'Game was successfully created.'
        format.html {
          redirect_to games_path
        }
        format.js { 
          render :update do |page|
            page['#new_game'].replace :partial => "game", :object => @game
            page['#add_game'].show
          end
        }
        format.xml  { render :xml => @game, :status => :created, :location => @game }
      else
        format.html {
          render :action => "new"
        }
        format.js { 
          render :update do |page| 
            page['#new_game'].replace :partial => "form"
          end
        }
        format.xml  { render :xml => @game.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /games/1/rating
  def rating
    game = Game.find_by_permalink(params[:game_id])
    game_rating = game.game_ratings.find_or_create_by_user_id(current_user.id)
    game_rating.rating = params[:rating].to_f
    respond_to do |format|
      if game_rating.save
        format.js {
          render :update do |page|
            page["##{dom_id(game)} .averagerating.box"].replace_html :partial => "game_rating", :locals => { :game => game }
            page["##{dom_id(game)} .play_options"].replace_html :partial => "play_options", :locals => { :game => game }
            page["##{dom_id(game)} .play_options"].highlight 1000
          end
        }
        format.html {
          redirect_to game
        }
      end
    end
    
  end

  # GET /games/1/edit
  def edit
    @game = Game.find_by_permalink(params[:id])
    respond_to do |format|
      format.html # edit.html.erb
      format.js {
        render :update do |page|
          page['#game_' + @game.id.to_s].replace :partial => "remote_form"
        end
      }
      format.xml  { render :xml => @game }
    end
  end

  # PUT /games/1
  # PUT /games/1.xml
  def update
    @game = Game.find_by_permalink(params[:id])

    respond_to do |format|
      if @game.update_attributes(params[:game])
        flash[:notice] = 'Game was successfully updated.'
        format.html { redirect_to(@game) }
        format.js { 
          render :update do |page| 
            page["#edit_game_#{@game.id}"].replace :partial => "game", :object => @game
          end
        }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.js { 
          render :update do |page| 
            page["#edit_game_#{@game.id}"].replace :partial => "remote_form"
          end
        }
        format.xml  { render :xml => @game.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.xml
  def destroy
    @game = Game.find_by_permalink(params[:id])
    @game.destroy

    respond_to do |format|
      format.html {
        redirect_to games_path
      }
      format.js { 
        render :update do |page| 
          page["#game_#{@game.id}"].blind_up
        end
      }
      format.xml  { head :ok }
    end
  end
end
