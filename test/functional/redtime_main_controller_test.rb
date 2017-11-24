require File.dirname(__FILE__) + '/../test_helper'

class RedtimeMainControllerTest < ActionController::TestCase

  fixtures :projects, :users, :roles, :versions

  def setup
    User.current = User.find(1)
    @request.session[:user_id] = 1
    @project = Project.find(1)
  end

  def test_index
    Role.find(1).add_permission! :view_kb_articles
    get :index, :id => @project.identifier
    assert_response :success
    assert_template 'index'
    assert_select 'h2', 'Ide kerül minden munkánk'
    #assert_select 'select#versions'
  end

end
