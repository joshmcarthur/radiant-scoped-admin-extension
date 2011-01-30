module ScopedAdmin
  module RoleExt
    def self.included(base)
      base.class_eval do
        def validate_restricted_roles
          return false if self.name.nil?
          return !Radiant::Config['restricted_roles'].include?(self.name)
        end
      end
      
      base.send(:validate, :validate_restricted_roles)
    end
  end
end
