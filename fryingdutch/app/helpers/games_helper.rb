module GamesHelper
  include TagsHelper
  
  def sub_tag_cloud(objects, classes, exclude)
    return if objects.empty?
    tag_map = {} 
    exclude_names = TagList.new
    exclude_names.add(exclude, :parse => true)
    
    max_count = 0
    objects.each do |o| 
      o.tags.each do |t| 
        unless exclude_names.include? t.name 
          tag_map[t] ||= 0
          count = tag_map[t] += 1
          max_count = count unless max_count > count
        end
      end
    end    
    
    tag_map.map do |tag, count|
      index = ((count / max_count) * (classes.size - 1)).round
      yield tag, classes[index]
    end    
    
  end

end
