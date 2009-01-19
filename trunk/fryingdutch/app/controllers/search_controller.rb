class SearchController < ApplicationController
  
  protect_from_forgery  :except => [:search]
  
  def search
    unless params[:q].blank?
      @games = Game.quick_search params[:q]
      @members = User.quick_search params[:q]
    end
    
    respond_to do |format|
      format.js {
        render :update do |page|
          page["#search input"].removeClass "searching"
          page["#search_result"].replace_html :partial => "quick_searchresult" unless params[:q].blank?
          page["#search_result"].replace_html :text => "" if params[:q].blank?
        end
      }
    end
    
  end
  
end
