class CreateObjectStates < ActiveRecord::Migration
 
  def self.up
    create_table :object_states do |t|
      t.string :state
      t.references :object, :polymorphic => true
      t.references :owner

      t.timestamps
    end
  end

  def self.down
    drop_table :object_states
  end
end
