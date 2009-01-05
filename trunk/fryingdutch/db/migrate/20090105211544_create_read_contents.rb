class CreateReadContents < ActiveRecord::Migration
  def self.up
    create_table :read_contents do |t|
      t.references :item, :polymorphic => true
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :read_contents
  end
end
