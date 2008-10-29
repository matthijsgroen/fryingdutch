
  GravatarHelper::DEFAULT_OPTIONS[:default] = "http://beta.fryingdutch.net:3000/images/avatar.png";
  
  OpenID::Util.logger = Logger.new(RAILS_ROOT + "/log/openid.log")