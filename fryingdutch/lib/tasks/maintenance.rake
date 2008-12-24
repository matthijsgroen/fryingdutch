namespace :maintenance do
  desc "Load fixtures from db/bootstrap into the database"
  
  task :fix_positions => :environment do
    while no_position = Comment.find(:first, :conditions => { :position => nil })
      puts "Fixing positions"
      list = Comment.find(:all, :conditions => { 
          :comment_on_id => no_position.comment_on_id, 
          :comment_on_type => no_position.comment_on_type, 
          :category => no_position.category 
        }, :order => "id" )
      list.each_with_index do |item, index|
        item.update_attributes(:position => index + 1)
      end
    end    
  end

end