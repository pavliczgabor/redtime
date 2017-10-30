Redmine::Plugin.register :redtime do
  name 'RedTime plugin'
  author 'Agilis kurzus csapat'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  permission :view_redtime_menu, :redtime_main => :index, :public => true
  menu :project_menu, :redtime_menu,{ :controller => 'redtime_main', :action => 'index' }, :caption => 'Redtime', :last => true
end
