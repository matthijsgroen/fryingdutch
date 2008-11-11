class CreateGameMetadatas < ActiveRecord::Migration
  def self.up
    create_table :game_metadatas do |t|
      t.references :game
      t.string :website
      t.string :forum
      t.string :community_site
      t.string :publisher
      t.string :publisher_url
      t.string :developer
      t.string :developer_url
      t.date :release_date
      t.string :players_worldwide
      t.string :players_netherlands
      t.string :languages
      t.float :cost
      t.string :cost_period
      t.boolean :micro_payments

      t.timestamps
    end
  end

  def self.down
    drop_table :game_metadatas
  end
end
