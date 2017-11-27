require File.dirname(__FILE__) + '/../test_helper'

class DataStructureTest < ActiveSupport::TestCase

  test "Constructor test" do
    #assert_equal 1, Project.count
    #assert_equal "Teszt projekt", Project.first.name
    subop=DataStructure.new('valami','Sprint1','RedTime1')

    assert_equal subop.dataItems, 'valami'
    assert_equal subop.namesOfSprints, 'Sprint1'
    assert_equal subop.project, 'RedTime'

  end

end
