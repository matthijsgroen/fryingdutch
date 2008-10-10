class AddOpenIdFieldsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :identity_url, :string
    add_column :users, :display_name, :string
    add_column :users, :nickname, :string
    add_column :users, :email, :string
    remove_column :users, :username
  end

  def self.down
    remove_column :users, :identity_url
    remove_column :users, :display_name
    remove_column :users, :nickname
    remove_column :users, :email
    add_column :users, :username, :string
  end
end
