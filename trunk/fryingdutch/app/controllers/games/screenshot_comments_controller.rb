class Games::ScreenshotCommentsController < ApplicationController
  
  before_filter :get_game, :get_screenshot
  
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.js { 
        render :update do |page| 
          page["##{dom_id(@screenshot)}"].replace :partial => "index.html.erb"
        end
      }
      end
  end
  
  def new
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end

  private
  def get_game
    @game = Game.find_by_permalink(params[:game_id])
  end
  def get_screenshot
    @screenshot_id = params[:screenshot_id]
    @screenshot = @game.screenshots.find(@screenshot_id)
  end
end
