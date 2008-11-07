module FaceboxRender
  
  def render_to_facebox( options = {} )
    @box = Facebox.new()
    #Not implemented (yet) in facebox
    #@box.name = options[:name].delete if options[:name]

    if options[:html]
      @box.content = options[:html]
    else
      options[:template] = "#{default_template_name}.html.erb" unless options[:tempate] or options[:action] or options[:partial]
      options[:layout] = false unless options[:layout]
      options[:locals] = { :box => @box }
      @box.content = render_to_string(options)
    end
    
    render :update do |page|
      page << "jQuery.facebox(#{@box.content.to_json})"
      page["##{@box.name} .footer"].prepend("<div class=\"message\">#{options[:msg]}</div>)") if options[:msg]
      
      if @box.has_navigation?
        page << "if ($(\"#facebox .navigation\").length == 0) {"
          page["#facebox .footer"].prepend "<p class=\"navigation\"></p>"
        page << "}"
        page["#facebox .navigation"].replace_html @box.navigation
      end
          
      yield(page) if block_given?
      
    end
  end
  
  # close an existed facebox, you can pass a block to update some messages
  def close_facebox
    render :update do |page|
      page << "jQuery.facebox.close();"
      yield(page) if block_given?
    end
  end

  # redirect_to other_path (i.e. reload page)
  def redirect_from_facebox(url)
    render :update do |page|
      page.redirect_to url
    end
  end
  
  private
  
  class Facebox
    attr_accessor :navigation, :content
    attr_reader :name
    
    def initialize()
      @name = "facebox"
      @navigation = ""
      @content = ""
    end
    
    def has_navigation?
      return !navigation.empty?
    end
  end
  
end