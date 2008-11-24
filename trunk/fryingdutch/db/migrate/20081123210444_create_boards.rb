class CreateBoards < ActiveRecord::Migration
  def self.up
    create_table :boards do |t|
      t.references :parent
      t.string :name
      t.string :description
      t.integer :position

      t.timestamps
    end
  end

  def self.down
    drop_table :boards
  end
end
