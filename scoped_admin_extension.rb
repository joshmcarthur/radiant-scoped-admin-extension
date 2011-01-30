# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class ScopedAdminExtension < Radiant::Extension
  version "0.5"
  description "Calls multi_site to site-scope users, snippets and layouts."
  url "http://github.com/joshmcarthur"
  
  # the work here is done by multi_site
  # once the classes are scoped, they become invisible to the wrong person
  # the only complications come from allowing sharing between sites
    
  def activate
    
    Radiant::Config['admin_change_site_roles'] = ['coordinator']
    Radiant::Config['restricted_roles'] = ['admin', 'coordinator']
    
    Layout.send :is_site_scoped, :shareable => true
    Snippet.send :is_site_scoped, :shareable => true
    Page.send :is_site_scoped
    Role.send :is_site_scoped, :shareable => true
    Role.send :include, ScopedAdmin::RoleExt
    User.send :is_site_scoped, :shareable => true
    ApplicationHelper.send :include, ScopedHelper
    
    Admin::ExtensionsController.send :include, ScopedAdmin::AdminExtensionsControllerExt
    Admin::LayoutsController.send :include, ScopedAdmin::AdminLayoutsControllerExt
    Admin::PagesController.send :include, ScopedAdmin::AdminPagesControllerExt
    Admin::SnippetsController.send :include, ScopedAdmin::AdminSnippetsControllerExt
    Admin::UsersController.send :include, ScopedAdmin::AdminUsersControllerExt
    Admin::RolesController.send :include, ScopedAdmin::AdminRolesControllerExt
    
        
    unless admin.users.edit.form && admin.users.edit.form.include?('choose_site')
      admin.users.edit.add :form, "choose_site", :after => "edit_roles" 
      admin.layouts.edit.add :form, "choose_site", :before => "edit_timestamp" 
      admin.snippets.edit.add :form, "choose_site", :before => "edit_filter"
      admin.pages.edit.add :form, "choose_site"
      admin.roles.edit.add :form, "choose_site"
    end
  end
end
