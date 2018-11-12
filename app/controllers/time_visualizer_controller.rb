class TimeVisualizerController < ApplicationController

  def index
    @project = Project.find(params[:id])
    @sprints_selection=[]
    @project.versions.each do |version|
      @sprints_selection<<[version.name,version.id]
    end
    
    @trackers_selection=[]
    @project.trackers.each do |tracker|
      @trackers_selection << [tracker.name, tracker.id]
    end
    
    #Szűrés az adott paraméterekkel.
    @dataItems = []
    if params.key?(:sprints)
    sprints=Version.find(params[:sprints])
    else
      sprints=@project.versions
    end
    
    if(params.key?(:trackers))
    trackers=Tracker.find(params[:trackers])
    else
      trackers=@project.trackers.to_enum
    end
  #megadott sprint és trackerek
    sprint_names=sprints.map{|f| f.name}
    trackernames=trackers.map{|f| f.name}

    #TODO: dokumentacio ir szurest a "projekthez rendelt megadott szerepkoru felhasznalora" is
    # Project.last.members.first.user.custom_field_value(UserCustomField.find_by(name: "Vállalt idő").id)
    #Project.last.versions.find_by('name LIKE ?', '%0.1%').c
    #TimeEntry.where(spent_on: start_date.to_s)
    # @work_hours = 0
    # @project.members.each do |member|
    #   @work_hours += member.user.custom_field_value(UserCustomField.find_by(name: "Vállalt idő").id).to_i
    # end
    # end_date = @project.versions.find_by('name LIKE ?', '%0.1%').effective_date.to_date
    # start_date = @project.versions.find_by('name LIKE ?', '%0.1%').created_on.to_date
    # while start_date != end_date + 1
    #   puts start_date
    #   start_date += 1
    #   TimeEntry.where(spent_on: start_date.to_s)
    # end
    # @dataItems feltoltese dummy adatokkal

    #@dataItems << StatItem.new(sprints.map{|f| f.name},trackers.map{|f| f.name}, {Date.new(2018,5, 20) => {:remaining_work_hour => 220, :remaining_issue_hour => 150 }})
    @dataItems << StatItem.new(0.1,"Feladat", {Date.new(2018,5, 20) => {:remaining_work_hour => 220, :remaining_issue_hour => 150 }})
    @dataItems << StatItem.new(0.1,"Feladat", {Date.new(2018,5, 20) => {:remaining_work_hour => 180, :remaining_issue_hour => 150 }})
    @dataItems << StatItem.new(0.1,"Feladat", {Date.new(2018,5, 22) => {:remaining_work_hour => 100, :remaining_issue_hour => 90 }})
    @dataItems << StatItem.new(0.1,"Feladat", {Date.new(2018,5, 25) => {:remaining_work_hour => 50, :remaining_issue_hour => 40 }})
    @dataItems << StatItem.new(0.1,"Feladat", {Date.new(2018,5, 28) => {:remaining_work_hour => 30, :remaining_issue_hour => 20 }})
    # puts @dataItems.first.remaining_hours.map{|i, t| t[:remaining_work_hour]}
    # puts "Boti"
    # puts @dataItems.first.remaining_hours.map{|i, t| i}
  end

end
