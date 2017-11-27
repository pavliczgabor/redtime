require File.dirname(__FILE__) + '/../test_helper'

class TimeReportControllerTest < ActionController::TestCase

  fixtures :projects, :users, :roles, :versions, :issues

  def setup
    User.current = User.find(1)
    @request.session[:user_id] = 1
    @project = Project.find(1)
  end

  def test_filter
    Role.find(1).add_permission! :view_kb_articles
    get :filter, :id => @project.identifier
    assert_response :success
    assert_template 'filter'
    assert_select 'h2', 'Ide kerül minden munkánk'
    #assert_select 'select#versions'
    assert_select 'select[id=versions]' do
      assert_select 'options',3
    end
  end

end