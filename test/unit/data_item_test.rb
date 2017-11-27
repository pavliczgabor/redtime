require File.dirname(__FILE__) + '/../test_helper'

class DataItemtTest < ActiveSupport::TestCase

  test "Constructor test" do
    #assert_equal 1, Project.count
    #assert_equal "Teszt projekt", Project.first.name
    subop=DataItem.new('valaki',DateTime.now.to_date,[3,2,1] )
    assert_equal subop.user, 'valaki'
    assert_equal subop.date, DateTime.now.to_date
    assert_equal subop.sprints, [3,2,1]

  end

end
