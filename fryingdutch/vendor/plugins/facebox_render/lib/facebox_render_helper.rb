module FaceboxRenderHelper

  def facebox_link_to(name, options = {}, html_options = nil)  
    link_to_function(name, "jQuery.facebox(function(){ #{remote_function(options)} })", html_options || options.delete(:html))
  end
  
  def facebox_navigation(&block)
    yield self if block_given?
  end
  
  def next(url)
    @box.navigation << facebox_link_to("&gt;", { :url => url }, { :class => "next" } )
  end
  
  def previous(url)
    @box.navigation << facebox_link_to("&lt;", { :url => url }, { :class => "previous" } )
  end
  
  def <<(text)
    @box.navigation << text
  end
 
end