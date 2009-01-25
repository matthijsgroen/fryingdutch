require 'json'

class SessionsController < ApplicationController
  
  def new
    # new.html.erb    
  end

  def rpx_token_signin
    rpx_token = params[:token]
    rpx = Net::HTTP.new('rpxnow.com', 443)
    rpx.use_ssl = true
    path = "/api/v2/auth_info"
    args = "apiKey=#{RPX_API_KEY}&token=#{rpx_token}"
    http_resp, response_data = rpx.post( path, args )
    
    rpx_data = JSON.parse( response_data )

    # for debug information
    # render :text => rpx_data.inspect
    # return
   
    if rpx_data["stat"] == "ok"
      options = {}
      options[:add_user] = params[:add] if (params[:add]) 
      user = User.find_or_create_by_rpx_profile(rpx_data["profile"], options)
      
      successful_login user unless params[:add]
      redirect_to settings_url if params[:add]
    elsif rpx_data["stat"] == "fail"
      #-1    Service Temporarily Unavailable
      #0   Missing parameter
      #1   Invalid parameter
      #2   Data not found
      #3   Authentication error
      messages = {
        "-1" => "Dienst tijdelijk niet beschikbaar",
        "0" => "Parameter ontbreekt",
        "1" => "Parameter ongeldig",
        "2" => "Gegevens niet gevonden",
        "3" => "Inloggegevens onjuist"      
      }
      failed_login messages[rpx_data["err"]["code"]]
    else
      failed_login "Het inlog proces is mislukt"
    end
  end  
  
  private
    def successful_login(user)
      session[:user_id] = user.id
      user.login_counter ||= 0
      user.login_counter += 1
      user.user_activities.create :session_start => Time.now, :session_end => Time.now, :time_spent => 0
      user.save
      redirect_to desktop_url
    end
    
    def failed_login(message)
      flash[:error] = message
      render :action => :new
    end
    
end
