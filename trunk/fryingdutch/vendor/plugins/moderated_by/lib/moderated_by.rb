module ActiveRecord #:nodoc:
  module ModeratedBy #:nodoc:
    def self.included(base)
      base.extend(ClassMethods)
    end
    
    module ClassMethods
      def moderated_by(group_alias, options = {})
        has_one :object_state, :as => :object, :dependent => :destroy
        after_create :create_state
        attr_accessor :owner
        validates_presence_of :owner
        
        include ActiveRecord::ModeratedBy::InstanceMethods
        
        class_eval <<-EOV
          def moderation_group
            Group.find_by_alias "#{group_alias.to_s }"                        
          end

        EOV
        
      end
    end
    
    module InstanceMethods
      def create_state
        ObjectState.create :object => self, :state => "pending", :owner_id => owner.id
        # send message to moderating group
        
      end
      
    end
  end
end

ActiveRecord::Base.send(:include, ActiveRecord::ModeratedBy)
