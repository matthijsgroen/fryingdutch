module ActiveRecord #:nodoc:
  
  module Reactor #:nodoc:
    module Is
    
      module TopicType #:nodoc:
        def self.included(base)
          base.extend(ClassMethods)
        end
        
        module ClassMethods
          def is_topic_type
            has_one :topic, :as => :parent, :dependent => :destroy
            delegate :title, :title=, :user_id, :user_id=, :to => :topic
            has_many :topic_reactions, :through => :topic
            
            after_save :save_topic
            include ActiveRecord::Reactor::Behaves::AsTopic::InstanceMethods
            alias_method_chain :initialize, :topic
          end
        end # ClassMethods
        
        module InstanceMethods
          def initialize_with_topic(attributes = nil)
            initialize_without_topic(attributes)
            self.topic = Topic.new(:parent => self)
          end
          
          def save_topic
            self.topic.save!
          end
          
        end # InstanceMethods
        
      end # TopicType
    end # IS
  end # Reactor
end # ActiveRecord

ActiveRecord::Base.send(:include, ActiveRecord::Reactor::Is::TopicType)
