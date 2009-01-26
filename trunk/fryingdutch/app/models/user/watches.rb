module UserWatches
  
  def watch(object)
    return if watching? object
    ObserveObject.create :user => self, :object => object
  end

  def watching?(object)
    r = ObserveObject.count :all, :conditions => { :user_id => self.id, 
      :object_id => object.id, :object_type => object.class.name }
    return r > 0
  end

  def unwatch(object)
    r = ObserveObject.find :first, :conditions => { :user_id => self.id, 
      :object_id => object.id, :object_type => object.class.name }
    r.destroy if r   
  end

end