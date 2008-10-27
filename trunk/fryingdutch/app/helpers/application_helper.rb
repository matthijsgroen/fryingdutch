# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def current_user
    @current_user
  end
  
  def ajax_message(text, options={})
    opts = { :type => :message }.update(options)
    
    "<div class=\"flash #{opts[:type].to_s}\">#{text}</div>"
  end

end
