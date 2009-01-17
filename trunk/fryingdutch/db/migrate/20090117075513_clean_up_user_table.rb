class CleanUpUserTable < ActiveRecord::Migration
  def self.up
    add_column :users, :state, :string, :default => "registration"
    remove_column :users, :identity_url
    remove_column :users, :display_name
    remove_column :users, :dob
      
    drop_table :open_id_authentication_associations
    drop_table :open_id_authentication_nonces
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
