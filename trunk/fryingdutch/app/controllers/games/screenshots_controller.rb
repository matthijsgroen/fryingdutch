class Games::ScreenshotsController < ApplicationController

  before_filter :get_game
  before_filter :login_required, :only => [:new, :create, :update, :destroy]

  def index
  end
  
  def new
  end

  def create
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
