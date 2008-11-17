class GameSupport::WorldOfWarcraftController < GameSupport::GameSupportController

  def self.features
    super.update({
      #:collect_info? => true,
      #:public_info? => true
    })
  end

  def collect_info
    @character_entries = WowCharacter.find_by_user_id(current_user.id)
    @character_entries ||= []
    @character_entries << WowCharacter.new
    
  end

end
