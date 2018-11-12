Redmine::Plugin.register :redtime do
  name 'RedTime plugin'
  author 'Agilis kurzus csapat'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  permission :view_redtime_menu, :time_visualizer => :index, :public => true
  menu :project_menu, :view_redtime_menu,{ :controller => 'time_visualizer', :action => 'index' }, :caption => 'Redtime', :last => true
end
