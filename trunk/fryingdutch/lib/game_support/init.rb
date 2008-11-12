module GameExtension
  
  def extension
    begin
      @extension ||= "GameExtension::#{permalink.underscore.camelize}".constantize.new(self)
    rescue
      @extension = GameExtension::Base.new(self)
    end
  end
  
  class Base
    def initialize(game)
      @game = game
    end
    
    def collect_info(page)
      # dummy method
    end
  end
  
  delegate :collect_info, :to => :extension
  
end

Dir[__FILE__.sub("init.rb", "") + "*.rb"].each { |file_name| require file_name unless file_name == __FILE__ }