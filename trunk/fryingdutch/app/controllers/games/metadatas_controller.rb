class Games::MetadatasController < ApplicationController
 
  before_filter :get_metadata
  before_filter :login_required, :only => [:new, :create, :update, :destroy]

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.js { render :partial => "show", :format => :html } # _show.html.erb
    end
  end
  
  def edit
    respond_to do |format|
      format.js { 
        render :update do |page|
          page["##{dom_id(@game)} .tab_contents"].replace_html :partial => "remote_form"
        end      
      }
    end    
  end
  
  def update
    respond_to do |format|
      if @metadata.update_attributes(params[:game_metadata])
        flash[:notice] = 'Metadata was successfully updated.'
        format.html { redirect_to game_metadata_path(@game) }
        format.js { 
          render :update do |page| 
            page["#edit_game_metadata_#{@metadata.id}"].replace :partial => "show"
            page["##{dom_id(@game)} .tab_contents"].highlight
          end
        }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.js { 
          render :update do |page|
            page["#edit_game_metadata_#{@game.id}"].replace :partial => "remote_form"
          end
        }
        format.xml  { render :xml => @metadata.errors, :status => :unprocessable_entity }
      end
    end
    
  end

  private
    def get_metadata
      @game = Game.find_by_permalink(params[:game_id])
      @game.game_metadata ||= GameMetadata.new
      @game.save if @game.game_metadata.new_record?
      @metadata = @game.game_metadata
    end
  
end
