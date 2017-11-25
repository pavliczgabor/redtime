# This is the data structure that should be  forwarded to the estimated time riport view
class EstimatedData
  extend ActiveModel::Naming
  
  attr_accessor :date, :estimatedSum, :factSum, :leftSum
 
  def initialize(date, estimatedSum, factSum, leftSum)
    @date=date
    @estimatedSum=estimatedSum
    @factSum=factSum
    @leftSum=leftSum
  end
  
  def persisted?
    false
  end
end


