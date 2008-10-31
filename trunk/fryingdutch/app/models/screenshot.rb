class Screenshot < ActiveRecord::Base
  
  has_attachment :content_type => :image, 
                 :storage => :file_system, 
                 :max_size => 3.megabytes,
                 :resize_to => '1024x768>',
                 :thumbnails => { :thumb => '100x75>' }

  validates_as_attachment
  
end
