# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  #helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'ca9769fca6c5fc26e0d28bd4b083bddb'

  before_filter :current_user
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  def current_user
    user_id = session[:user_id]
    @current_user = nil
    @current_user = User.find user_id unless user_id.nil?
  end

  def login_required
    if current_user.nil?
      flash[:message] = "Je moet ingelogd zijn om deze pagina te bekijken."
      redirect_to root_url
    end
  end
  
end
