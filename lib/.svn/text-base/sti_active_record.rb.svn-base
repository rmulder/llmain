## Rails 3.0.3 specific code.
## Need to review when upgrading Rails
## Used to hack around message_type in smb_promo_messages STI column
## Used to promote class types ThirdPartyOffer, Offer, Message, Job, SocialCoupon

module ActiveRecord
  class Base
    class << self
      private
        
        def find_sti_class(type_name)
          # Narrow scope of set_inheretence_column changes to PromoMessage class to reduce chances of bugs introduced
          if self.name == "PromoMessage"
            type_name = type_name.singularize.camelize
            sti_logger = Logger.new('log/sti_logger.log')
            sti_logger.info type_name
            sti_logger.info self.inspect
          end

          if type_name.blank? || !columns_hash.include?(inheritance_column)
            self
          else
            begin
              if store_full_sti_class
                ActiveSupport::Dependencies.constantize(type_name)
              else
                compute_type(type_name)
              end
            rescue NameError
              raise SubclassNotFound,
                "The single-table inheritance mechanism failed to locate the subclass: '#{type_name}'. " +
                "This error is raised because the column '#{inheritance_column}' is reserved for storing the class in case of inheritance. " +
                "Please rename this column if you didn't intend it to be used for storing the inheritance class " +
                "or overwrite #{name}.inheritance_column to use another column for that information."
            end
          end
        end

    end
  end
end
