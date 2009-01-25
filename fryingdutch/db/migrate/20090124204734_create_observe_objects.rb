class CreateObserveObjects < ActiveRecord::Migration
  def self.up
    create_table :observe_objects do |t|
      t.references :object, :null => false, :polymorphic => true
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :observe_objects
  end
end
