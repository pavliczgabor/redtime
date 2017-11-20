require File.dirname(__FILE__) + '/../test_helper'
 
class ProjectTest < ActiveSupport::TestCase

  fixtures :projects

  test "Loaded test project" do
    assert_equal 1, Project.count
    assert_equal "Teszt projekt", Project.first.name
  end

end
