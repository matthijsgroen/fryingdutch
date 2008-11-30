atom_feed do |feed|
  feed.title "Fryingdutch.net Games"
  feed.updated @games.last.created_at
  
  @games.each do |game|
    feed.entry game do |entry|
      entry.title game.name
      entry.content game.description
      entry.author { |author| author.name("Fryingdutch.net") }
    end
  end

end