class Games::UsershotsController < ApplicationController
  before_filter :get_game

  def index
    @shots = @game.usershots
    
    respond_to do |format|
      format.html
      format.js { render_to_facebox }
    end
  end

  def show
    @screenshot = @game.usershots.find params[:id]
    
    respond_to do |format|
      format.html
      format.js { render_to_facebox }
    end
  end

  private
    def get_game
      @game = Game.find_by_permalink(params[:game_id])
    end

end
