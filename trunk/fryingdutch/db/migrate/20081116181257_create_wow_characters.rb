class CreateWowCharacters < ActiveRecord::Migration
  def self.up
    create_table :wow_characters do |t|
      t.string :name
      t.string :realm
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :wow_characters
  end
end
