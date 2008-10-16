module ActiveRecord #:nodoc:
  module Reactor #:nodoc:
    module Topic #:nodoc:
      def self.included(base)
        base.extend(ClassMethods)
      end
      module ClassMethods
        def is_topic_type
          has_one :topic, :as => :topicable, :dependent => :destroy
          delegate :title, :user_id, :to => :topic
          
          #before_save :save_cached_tag_list
          #after_save :save_tags
          
          #include ActiveRecord::Acts::Taggable::InstanceMethods
          #extend ActiveRecord::Acts::Taggable::SingletonMethods
          
          #alias_method_chain :reload, :tag_list
        end
      end
      
    end
  end
  
  
end

ActiveRecord::Base.send(:include, ActiveRecord::Reactor::Topic)
