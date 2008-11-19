class Games::ScreenshotsController < ApplicationController

  before_filter :get_game
  before_filter :login_required, :only => [:new, :create, :update, :destroy]

  def index
    @shots = @game.screenshots.paginate :page => params[:page], :per_page => 3
    
    respond_to do |format|
      format.html
      format.js { render_to_facebox }
    end
  end

  def show
    @screenshot = @game.screenshots.find params[:id]
    
    respond_to do |format|
      format.html
      format.js { render_to_facebox }
    end
  end
  
  def new
    @screenshot = @game.screenshots.new
    @screenshot.content = Screenshot.new
    
    respond_to do |format|
      format.html
      format.js { render_to_facebox }
    end
  end

  def create
    @screenshot = @game.screenshots.new

    @screenshot.content = Screenshot.new(params[:comment][:screenshot])
    if @screenshot.content.save
      flash[:notice] = 'Afbeelding is toegevoegd aan spel'
      @screenshot.user = current_user
      @screenshot.category = params[:comment][:category]
      @screenshot.save
      redirect_to @screenshot.content.public_filename     
    else
      render :action => :new
    end
  end

  def destroy
    screenshot = @game.screenshots.find params[:id]
    screenshot.destroy
    
      respond_to do |format|
        format.js {
          render :update do |page|
            page["##{dom_id(screenshot)}"].hide "drop" 
          end
        }
      end
  end

  def update
  end

  private
    def get_game
      @game = Game.find_by_permalink(params[:game_id])
    end

end
