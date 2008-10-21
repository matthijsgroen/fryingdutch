class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.references :comment_on, :polymorphic => true
      t.references :content, :polymorphic => true
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
