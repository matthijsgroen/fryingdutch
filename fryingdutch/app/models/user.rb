class User < ActiveRecord::Base

  SYSTEM = 0; # UserID of the system User.

  has_many :user_games, :dependent => :destroy
  has_many :game_ratings, :dependent => :destroy
  has_many :user_games_playing, :class_name => "UserGame", :conditions => "user_games.end_date IS NULL", :dependent => :destroy
  has_many :games_playing, :class_name => "Game", :through => :user_games_playing, :source => :game
  has_many :identities, :class_name => "UserIdentity", :dependent => :destroy
  has_one :profile, :class_name => "UserProfile", :dependent => :destroy

  validates_uniqueness_of :nickname, :unless => :registration?

  def before_save
    self.permalink = create_permalink 
  end
  
  def after_create
    self.permalink = create_permalink
    save
  end
  
  def registration?
    self.state == "registration"
  end
  
  def plays(game)
    self.user_games.create :start_date => Date.today, :game => game, :user => self
  end

  def to_param
    return permalink if permalink
    save
    permalink
  end
  
  def self.find_or_create_by_rpx_profile(profile_data, options = {})
    identity_url = profile_data["identifier"]
    userid = UserIdentity.find_by_identity_url(identity_url)
    if userid
      user = userid.user
      userid.username = profile_data["preferredUsername"]
      userid.save
    elsif options[:add_user]
      user = User.find options[:add_user]
      UserIdentity.create :user_id => user.id, :identity_url => identity_url, :username => profile_data["preferredUsername"]
    else
      user = User.create
      UserProfile.create :user_id => user.id
      UserIdentity.create :user_id => user.id, :identity_url => identity_url, :username => profile_data["preferredUsername"]
    end
    assign_registration_attributes user, profile_data
    user.profile.save
    user.save
    
    user
  end
  
  def self.quick_search(query)
    condition_values, conditions, index = {}, [], 0
    query.split.each { |name_part|
      index += 1
      value_alias = "f#{index}".to_sym
      conditions << "nickname LIKE :#{value_alias}"
      condition_values[value_alias] = "%#{name_part}%"
    }
    find :all, :conditions => [conditions.join(" AND "), condition_values]
  end
  
  private
    def create_permalink
      if self.nickname
        "#{id}-#{nickname.gsub(/[^a-z0-9]+/i, '-')}".downcase
      else
        "#{id}"
      end
    end

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

    # registration is a hash containing the valid sreg keys given above
    # use this to map them to fields of your user model
    def self.assign_registration_attributes(user, registration)
      [
        ["email", "verifiedEmail", {}],
        ["profile.full_name", "name.formatted", {}],
        ["profile.dob", "birthday", {}],
        ["nickname", "preferredUsername", { :if => user.registration? }],
        ["profile.country", "address.country", {}],
        ["profile.gender", "gender", { :convert => lambda { |v| v == "male" } }]
      ].each do |attribute, path, options|
        if (options.has_key?(:if) and options[:if]) or (!options.has_key?(:if))
          value = registration
          path.split(".").each { |i| value = value[i] ? value[i] : "" }
          unless value.blank?
            o = user
            attr_path = attribute.split(".").reverse
            while attr_path.size > 1
              o = o.send(attr_path.pop)
            end
            value = options[:convert].call(value) if options.has_key? :convert
            o.send "#{attr_path.first}=", value
          end
        end
      end      
    end

end
