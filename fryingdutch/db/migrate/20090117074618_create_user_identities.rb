class CreateUserIdentities < ActiveRecord::Migration
  def self.up
    create_table :user_identities do |t|
      t.references :user
      t.string :identity_url

      t.timestamps
    end
  end

  def self.down
    drop_table :user_identities
  end
end
