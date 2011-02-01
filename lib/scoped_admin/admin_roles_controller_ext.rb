module ScopedAdmin
  module AdminRolesControllerExt
      
    def self.included(base)
      base.class_eval do        
        only_allow_access_to :index, :show, :new, :create, :edit, :update, :remove, :destroy,
          :when => [:coordinator, :admin],
          :denied_url => { :controller => 'pages', :action => 'index' },
          :denied_message => 'You must have the correct privileges to perform this action.'       
      end
    end
  end
end
