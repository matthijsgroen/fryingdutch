class MoveUserDataToSubtables < ActiveRecord::Migration
  
  class User < ActiveRecord::Base
  end

  class UserProfile < ActiveRecord::Base
  end

  class UserIdentity < ActiveRecord::Base
  end
  
  def self.up
    User.find(:all).each do |user|
      UserProfile.create \
        :user_id => user.id,
        :full_name => user.display_name,
        :dob => user.dob,
        :gender => nil,
        :country => nil
      UserIdentity.create \
        :user_id => user.id,
        :identity_url => user.identity_url
    end    
  end

  def self.down
    UserProfile.delete_all
    UserIdentity.delete_all
  end
end
