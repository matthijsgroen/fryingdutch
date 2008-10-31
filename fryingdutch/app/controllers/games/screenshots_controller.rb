class Games::ScreenshotsController < ApplicationController

  before_filter :get_game
  before_filter :login_required, :only => [:new, :create, :update, :destroy]

  def index
  end
  
  def new
    @screenshot = @game.screenshots.new
    @screenshot.content = Screenshot.new
  end

  def create
    @screenshot = @game.screenshots.new

    @screenshot.content = Screenshot.new(params[:comment][:screenshot])
    if @screenshot.content.save
      flash[:notice] = 'Mugshot was successfully created.'
      @screenshot.user = current_user
      @screenshot.category = "screenshot"
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
