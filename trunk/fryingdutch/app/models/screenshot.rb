class Screenshot < ActiveRecord::Base
  
  has_attachment :content_type => :image, 
                 :storage => :file_system, 
                 :max_size => 3.megabytes,
                 :thumbnails => { 
                  :thumb => '100x75>', 
                  :large => '800x600>' 
                 }

  validates_as_attachment
  
end
