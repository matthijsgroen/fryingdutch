require 'json'

class SessionsController < ApplicationController
  #include OpenIdAuthentication
  
  protect_from_forgery :except => [:create]
  
  def new
    
  end
  
  def create
    if using_open_id?
      open_id_authentication nil
    #else
      #password_authentication(params[:name], params[:password])
    end
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

    # -- GMAIL.COM
    #{
    #  "profile"=>{
    #    "verifiedEmail"=>"matthijs.groen@gmail.com", 
    #    "displayName"=>"matthijs.groen", 
    #    "preferredUsername"=>"matthijs.groen", 
    #    "identifier"=>"https://www.google.com/accounts/o8/id?id=AItOawkmv-nqEt3iZ7xybYrzlmQf-LY7ujEz_GE", 
    #    "email"=>"matthijs.groen@gmail.com"
    #  }, 
    #  "stat"=>"ok"
    #}

    # -- MyOpenID.COM
    #{
    #  "profile"=>{
    #    "photo"=>"http://www.myopenid.com/image?id=66792", 
    #    "address"=>{
    #      "country"=>"Netherlands"
    #    }, 
    #    "name"=>{
    #      "formatted"=>"Matthijs Groen"
    #    }, 
    #    "verifiedEmail"=>"matthijs.groen@gmail.com", 
    #    "displayName"=>"Matthijs Groen", 
    #    "preferredUsername"=>"THAiSi", 
    #    "url"=>"http://thaisi.myopenid.com/", 
    #    "gender"=>"male", 
    #    "birthday"=>"1981-05-31", 
    #    "identifier"=>"http://thaisi.myopenid.com/", 
    #    "email"=>"matthijs.groen@gmail.com"
    #  }, 
    #  "stat"=>"ok"
    #}
    
    if rpx_data["stat"] == "ok"
      user = User.find_or_create_by_identity_url(rpx_data["profile"]["identifier"])
      assign_registration_attributes user, rpx_data["profile"]
      unless user.save
        flash[:error] = "Error saving the fields from your OpenID profile: #{user.errors.full_messages.to_sentence}"
      end
      successful_login user
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
  
  protected

    # registration is a hash containing the valid sreg keys given above
    # use this to map them to fields of your user model
    def assign_registration_attributes(user, registration)
      [
        ["email", ["verifiedEmail"]],
        ["nickname", ["preferredUsername"]],
        ["display_name", ["name", "formatted"]],
        ["dob", ["birthday"]]
      ].each do |attribute, path|
        value = registration
        path.each { |i| value = value[i] ? value[i] : "" }
        user.send "#{attribute}=", value
      end      
    end

  private
    def successful_login(user)
      session[:user_id] = user.id
      user.login_counter ||= 0
      user.login_counter += 1
      user.save
      redirect_to desktop_url
    end
    
    def failed_login(message)
      flash[:error] = message
      render :action => :new
    end
    
end
