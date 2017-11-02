# This is the data structure that should be  forwarded to the view
# dataItems: it is an array of DataItem class
# projectName: You should pass the name of the selected project
# numOfSprints: If it is sprint filtered you supposed to add only the current number of the sprint, otherwise it should be equal to the array of sprints.
class DataStructure
  extend ActiveModel::Naming
  
  attr_accessor :dataItems, :numOfSprints, :projectName
 
  def initialize(dataItems, numOfSprints, project)
    @dataItems=dataItems
    @numOfSprints=numOfSprints
    @sprints=projectName
  end
  
  def persisted?
    false
  end
end


