class AddDescriptionToScreenshot < ActiveRecord::Migration
  def self.up
    add_column :screenshots, :description, :text 
  end

  def self.down
    remove_column :screenshots, :description
  end
end
