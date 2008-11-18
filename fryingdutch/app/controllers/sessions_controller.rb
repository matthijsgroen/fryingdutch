class SessionsController < ApplicationController
  include OpenIdAuthentication
  
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

  protected
#    def password_authentication(name, password)
#      if @current_user = @account.users.find_by_name_and_password(params[:name], params[:password])
#        successful_login
#      else
#        failed_login "Sorry, that username/password doesn't work"
#      end
#    end

    def open_id_authentication(identity_url)
      # Pass optional :required and :optional keys to specify what sreg fields you want.
      # Be sure to yield registration, a third argument in the #authenticate_with_open_id block.
      authenticate_with_open_id(identity_url, :required => [:nickname], :optional => [:fullname, :email, :gender, :dob]) do |status, identity_url, registration|
        case status.status
        when :missing
          if RAILS_ENV == "development" # offline mode
            @current_user = User.find_by_identity_url(identity_url)
            successful_login
            return
          end          
          failed_login "Sorry, de OpenID server kon niet worden gevonden"
        when :canceled
          failed_login "OpenID verificatie was geannuleerd"
        when :failed
          failed_login "Sorry, de OpenID verificatie was mislukt"
        when :successful
          @open_id_url = identity_url
          begin
            return missing_data("Sorry, we willen op zijn minst je nickname weten!") if registration["nickname"].blank? 
          rescue
            return missing_data("Sorry, we willen op zijn minst je nickname weten!")
          end
          @current_user = User.find_or_create_by_identity_url(identity_url)
          @current_user.login_counter ||= 0
          @current_user.login_counter += 1
          assign_registration_attributes!(registration)
          unless @current_user.save
            flash[:error] = "Error saving the fields from your OpenID profile: #{current_user.errors.full_messages.to_sentence}"
          end
          successful_login
        end
      end
    end

  private
    def successful_login
      session[:user_id] = @current_user.id
      redirect_to desktop_url
    end
    
    def failed_login(message)
      flash[:error] = message
      render :action => :new
    end

    def missing_data(message)
      flash[:error] = message
      #use this for displaying targeted help for big known providers to assist users
      @open_id_provider = nil
      @open_id_provider = "myopenid" if @open_id_url.contains? "myopenid.com"
      
      render :action => :missing_data
    end

    # registration is a hash containing the valid sreg keys given above
    # use this to map them to fields of your user model
    def assign_registration_attributes!(registration)
      model_to_registration_mapping.each do |model_attribute, registration_attribute|
        unless registration[registration_attribute].blank?
          @current_user.send "#{model_attribute}=", registration[registration_attribute]
        end
      end
    end

    def model_to_registration_mapping
      { :nickname => 'nickname', :email => 'email', :display_name => 'fullname', :dob => 'dob' }
    end
    
end
