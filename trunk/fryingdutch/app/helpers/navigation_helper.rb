module NavigationHelper

  def bar_link_to(name, options = {}, html_options = {}, &block)
    bar = NavigationBar.new self

    # Create normal link, add behavior
    html_options[:rel] = "navbar"
    html_options[:id] = bar.link_id
    concat link_to(name, options, html_options), block.binding
    
    # Create navigation bar
    concat "<div id=\"#{bar.id}\" class=\"navbar\">", block.binding
    yield bar if block_given?
    bar.close()
    concat bar.contents, block.binding
    concat "</div>", block.binding
  end
  
  #This method could use some upgrading; e.g., to allow icons or so (admin on / off icon)
  def disable_bar(name, options = {})
    options[:name] = "navbar" unless options[:name]
    options[:id] = "able_#{options[:name]}"
    "<div class=\"able_navbar\">"+link_to_function(name, "$(this).toggleClass('active')", options)+"</div>"
  end

  class NavigationBar
    
    def initialize(helpers_ref, name = "navbar")
      @contents = ""
      @name = name
      @id = "#{@name}_#{String.random}"
      @open_id = "open_#{id}"
      @link_id = "link_#{id}"
      @helpers = helpers_ref
    end
    
    attr_reader :contents, :open_id, :id, :link_id, :name
    
    def open_link_to(name, options = {}, html_options = {})
      html_options[:id] = open_id
      @contents << @helpers.link_to(name, options, html_options) + " "
    end
    
    def <<(text)
      @contents << text + " " unless text.nil?
    end
    
    def close()
      @contents << @helpers.link_to_function("X", "$('##{id}').hide()", :class => "close") + " "
    end
    
  end

  def navigation(&block)
    concat "<table class=\"navigation\"><tr>", block.binding
    nav = Navigator.new self
    yield nav if block_given?
    concat nav.contents, block.binding
    concat "</tr></table>", block.binding
  end
  
  class Navigator
    
    def initialize(helpers_ref)
      @contents = ""  
      @helpers = helpers_ref
    end
    
    attr_reader :contents
    
    def next(url)
      @contents << "<td>"+@helpers.link_to("&gt;", url, :class => "next", :rel => "remote")+"</td>"
    end
    
    def previous(url)
      @contents << "<td>"+@helpers.link_to("&lt;", url, :class => "previous", :rel => "remote")+"</td>"
    end
    
    def <<(text)
      @contents << "<td>"+text+"</td>" unless text.nil?
    end
    
  end

end