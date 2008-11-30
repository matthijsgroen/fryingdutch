module ActiveRecord #:nodoc:
  module Has #:nodoc:
    module Permalink #:nodoc:
      def self.included(base)
        base.extend(ClassMethods)
      end
      
      module ClassMethods
        def has_permalink
          validates_presence_of :name
          validates_each :name do |record, attr, value|
            record.errors.add attr, 'Een soortgelijke naam is al in gebruik!' if not record.new_record? and find :first, :conditions => ["permalink LIKE ? AND id <> ?", record.get_permalink, record.id]
            record.errors.add attr, 'Een soortgelijke naam is al in gebruik!' if record.new_record? and find :first, :conditions => ["permalink LIKE ?", record.get_permalink]
          end
          
          before_save :assign_permalink
          after_save :update_children_permalink
          
          include ActiveRecord::Has::Permalink::InstanceMethods
        end
      end
      
      module InstanceMethods
        def assign_permalink
          self.permalink = get_permalink
        end
        
        def update_children_permalink
          children.each { |child| child.save } if respond_to? :children
        end
        
        def get_permalink
          name = self.id
          name = "#{self.name.gsub(/[^a-z0-9]+/i, '-')}".downcase if respond_to? :name
          if respond_to? :parent
            name = "#{parent.permalink}\\#{name}" if parent.respond_to? :permalink
          end          
          name
        end
      
        def to_param
          assign_permalink unless permalink
          return permalink
        end

      end
    end
  end
end

ActiveRecord::Base.send(:include, ActiveRecord::Has::Permalink)
