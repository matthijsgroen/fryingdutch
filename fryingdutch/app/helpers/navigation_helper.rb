module NavigationHelper

#  def facebox_link_to(name, options = {}, html_options = nil)  
#    link_to_function(name, "jQuery.facebox(function(){ #{remote_function(options)} })", html_options || options.delete(:html))
#  end
  
  def navigation(&block)
    concat "<div class=\"navigation\">", block.binding
    nav = Navigator.new self
    yield nav if block_given?
    concat nav.contents, block.binding
    concat "</div>", block.binding
  end

  class Navigator
    
    def initialize(helpers_ref)
      @contents = ""  
      @helpers = helpers_ref
    end
    
    attr_reader :contents
    
    def next(url)
      @contents << @helpers.link_to("&gt;", url, :class => "next", :rel => "remote")
    end
    
    def previous(url)
      @contents << @helpers.link_to("&lt;", url, :class => "previous", :rel => "remote")
    end
    
    def <<(text)
      @contents << text
    end
    
  end

end