class GameSupport::WorldOfWarcraftController < GameSupport::GameSupportController

  def self.features
    super.update({
      :collect_info? => true#,
      #:public_info? => true
    })
  end

end
