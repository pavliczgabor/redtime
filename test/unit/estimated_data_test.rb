require File.dirname(__FILE__) + '/../test_helper'

class EsTimedDateTest < ActiveSupport::TestCase

  test "Constructor test" do
    #assert_equal 1, Project.count
    #assert_equal "Teszt projekt", Project.first.name

    subop=EsTimedDate.new(DateTime.now.to_date,'5','10','8' )
    assert_equal subop.date, DateTime.now.to_date
    assert_equal subop.estimatedSum, '5'
    assert_equal subop.factSum, '10'
    assert_equal subop.leftSum, '8'

  end

end
