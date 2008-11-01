class Games::ScreenshotsController < ApplicationController

  before_filter :get_game
  before_filter :login_required, :only => [:new, :create, :update, :destroy]

  def index
  end

  def show
    @screenshot = @game.screenshots.find params[:id]
    
  end
  
  def new
    @screenshot = @game.screenshots.new
    @screenshot.content = Screenshot.new
  end

  def create
    @screenshot = @game.screenshots.new

    @screenshot.content = Screenshot.new(params[:comment][:screenshot])
    if @screenshot.content.save
      flash[:notice] = 'Afbeelding is toegevoegd aan spel'
      @screenshot.user = current_user
      @screenshot.category = params[:comment][:category]
      @screenshot.save
      render :action => :new
    else
      render :action => :new
    end
  end

  def destroy
  end

  def update
  end

  private
    def get_game
      @game = Game.find_by_permalink(params[:game_id])
    end

end
