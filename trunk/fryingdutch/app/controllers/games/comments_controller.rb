class Games::CommentsController < ApplicationController
  
  before_filter :get_game
  before_filter :login_required, :only => [:create, :destroy]

  def index
    @comments = @game.comments
    @text_comment = TextComment.new    
    respond_to do |format|
      format.html # index.html.erb
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
      comment.category = "comment"
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
    @text_comment = @comment.content

    respond_to do |format|
      format.js {
        render :update do |page|
          page << "if ($(\"##{dom_id(@comment)} .edit_content\").length == 0) {"
          page["##{dom_id(@comment)} .message"].after render(:partial => "edit_comment")
          page << "}"
          page["##{dom_id(@comment)} .edit_content"].show
          page["##{dom_id(@comment)} .comment_options"].hide
          page["##{dom_id(@comment)} .message"].hide
          page["##{dom_id(@comment)} textarea"].focus
        end
      }
    end
  end
  
  def update
    @comment = @game.comments.find params[:id]
    @text_comment = @comment.content

    respond_to do |format|
      if @text_comment.update_attributes(params[:text_comment])
        flash[:notice] = 'Comment was successfully updated.'
        format.js { 
          render :update do |page| 
            page["##{dom_id(@comment)}"].replace :partial => "comment"
          end
        }
      else
        flash[:error] = "Comment wasn't successfully updated, please try again."
      end
    end
   
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
