
  GravatarHelper::DEFAULT_OPTIONS[:default] = "http://beta.fryingdutch.net:3000/images/avatar.png";
  
  if ENV['RAILS_ENV'] == "production"
    def Kernel.puts(*args)
      #nothing.
    end
  end