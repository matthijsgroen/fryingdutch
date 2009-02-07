class Game < ActiveRecord::Base
  
end

class AddStateToGame < ActiveRecord::Migration
  
  class ObjectState < ActiveRecord::Base
    belongs_to :object, :polymorphic => true
  end
  
  def self.up
    games = Game.find :all
    games.each do |game|
      os = ObjectState.new
      os.object = game
      os.owner_id = 1
      os.state = "active"
      os.save
    end    
  end

  def self.down
  end
end
