class GameSupport::GameSupportController < ApplicationController

  def self.features
    {
      :collect_info? => false,
      :public_info? => false
    }
  end

end