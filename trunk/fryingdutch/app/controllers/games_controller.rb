class GamesController < ApplicationController
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
    @game = Game.find(params[:id])

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
      format.js {
        render :update do |page|
          page['#add_game'].replace :partial => "form"
        end
      }
      format.xml  { render :xml => @game }
    end
  end

  # GET /games/1/edit
  def edit
    @game = Game.find(params[:id])

    respond_to do |format|
      format.js {
        render :update do |page|
          page['#game_' + @game.id.to_s].replace :partial => "form"
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
        format.js { 
          render :update do |page|
            @games = Game.find :all
            page['#game_list'].replace_html :partial => "game", :collection => @games
            page['#game_list .game:last'].after link_to_remote("Voeg een spel toe", :url => new_game_path, :html => { :id => "add_game" })
          end
        }
        format.xml  { render :xml => @game, :status => :created, :location => @game }
      else
        format.js { 
          render :update do |page| 
            page['#new_game'].replace :partial => "form"
          end
        }
        format.xml  { render :xml => @game.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /games/1
  # PUT /games/1.xml
  def update
    @game = Game.find(params[:id])

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
            page["#edit_game_#{@game.id}"].replace :partial => "form"
          end
        }
        format.xml  { render :xml => @game.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.xml
  def destroy
    @game = Game.find(params[:id])
    @game.destroy

    respond_to do |format|
      format.js { 
        render :update do |page| 
          page["#game_#{@game.id}"].fade
        end
      }
      format.xml  { head :ok }
    end
  end
end
