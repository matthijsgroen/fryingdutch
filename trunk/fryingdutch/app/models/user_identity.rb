class UserIdentity < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :user_id, :identity_url
  validates_uniqueness_of :identity_url
  
  def identity_provider
    if /^https:\/\/www.google.com\/accounts\/o8\/id\?id=/.match(self.identity_url)
      "Google Account"
    else
      self.identity_url
    end
  end
  
end
