class Games::CommentsController < ApplicationController
  
  before_filter :get_game
  before_filter :login_required, :only => [:create, :destroy]

  def index
    @comments = @game.comments
    @text_comment = TextComment.new    
    respond_to do |format|
      format.js { render :partial => "index" } # _index.js.erb
    end
  end
  
  def create
    @text_comment = TextComment.new params[:text_comment]
    success = true
    if @text_comment.save
      comment = Comment.new
      comment.comment_on = @game
      comment.content = @text_comment
      comment.user = current_user
      unless comment.save
        @text_comment.destroy
        success = false
      end
    else
      success = false
    end
    
    refresh_js :highlight => comment
  end
  
  def destroy
    #TODO: Check for correct rights
    comment = @game.comments.find params[:id]
    comment.destroy
    
    refresh_js :blind_up => comment
  end
  
  def edit
    @comment = @game.comments.find params[:id]
    @text_comment = @comment.comment_on

    respond_to do |format|
      format.js {
        render :update do |page|
          page["##{dom_id(@comment)} .message"].replace_html :partial => "edit_comment"
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
  
    def refresh_js(options = {})
      @comments = @game.comments
      @text_comment = TextComment.new
      respond_to do |format|
        format.js {
          render :update do |page|
            delay = 0
            if options[:blind_up]
              page["##{dom_id(options[:blind_up])}"].blind_up 
              delay = 0.5
            end
            page.delay delay do
              page["##{dom_id(@game)} .tab_contents"].replace_html :partial => "index"
              page["##{dom_id(@game)} .game_menu a.comments"].replace_html "Speler commentaar (#{@game.comments.count})"
              page["##{dom_id(@game)} .game_menu a.comments"].highlight
              page["##{dom_id(options[:highlight])}"].highlight if options[:highlight] 
            end
          end
        }
      end
    end

end
