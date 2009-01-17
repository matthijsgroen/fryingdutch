class AddPreferedUsernameAndPrimaryToIdentifierTable < ActiveRecord::Migration
  def self.up
    add_column :user_identities, :username, :string
    add_column :user_identities, :primary_profile, :boolean, :default => false
  end

  def self.down
    remove_column :user_identities, :username
    remove_column :user_identities, :primary_profile
  end
end
