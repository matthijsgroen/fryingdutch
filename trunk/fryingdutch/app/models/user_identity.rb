class UserIdentity < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :user_id, :identity_url
  validates_uniqueness_of :identity_url
end
