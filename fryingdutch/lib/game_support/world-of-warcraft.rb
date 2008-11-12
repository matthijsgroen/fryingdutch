module GameExtension
  
  class WorldOfWarcraft < Base  
    def collect_info(page)
      page << "alert('kiekeboe')"
    end
  end
  
  
end