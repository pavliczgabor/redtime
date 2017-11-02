# This is the class of an item that should be put in an array into DataStrucure object and then send to the view
# user: basically we just need a UserName/or an object if the plugin is gonna be more advanced later?
# date: date of the work
# sprints: it should be an array of Integers which contains the spent hours of certain sprints. If we filter on sprint as well, then it should contain only one item (the spent hours on that sprint on the given date)
# If it is sprint filtered you supposed to add the number of that certain sprint.
class DataItem
  extend ActiveModel::Naming
  
  attr_accessor :user, :date, :sprints
 
  def initialize(user, date, sprints)
    @user=user
    @date=date
    @sprints=sprints
  end
  
  def persisted?
    false
  end
end


