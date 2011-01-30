module ScopedAdmin
  module AdminExtensionsControllerExt
    def self.included(base)
      base.class_eval do
        only_allow_access_to :index,
          :when => ['can_manage_extensions', :coordinator],
          :denied_url => { :controller => 'pages', :action => 'index' },
          :denied_message => 'You must have the correct privileges to perform this action.'     
      end
    end
  end
end
