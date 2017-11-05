# This is the format that the submit page should receive.

class SubmitOptions
  extend ActiveModel::Naming
  attr_accessor :projects, :sprints, :names

  def initialize(projects, sprints, names)
    @projects=projects
    @sprints=sprints
    @names=names
  end
  def persisted?
    false
  end
end