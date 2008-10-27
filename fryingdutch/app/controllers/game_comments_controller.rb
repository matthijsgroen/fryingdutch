class GameCommentsController < ApplicationController
  
  before_filter :get_game

  def index
    @comments = @game.comments
    respond_to do |format|
      format.js { render :partial => "comments" }
    end
  end
  
  private
    def get_game
      @game = Game.find_by_permalink(params[:game_id])
    end

end
