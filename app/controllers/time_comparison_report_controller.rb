class TimeComparisonReportController < ApplicationController
  def filter
    #ez nem fog kelleni, hiszen a projekt eleve kivan választva
    @projectAll = Project.all
    @projectAll_selection=[]

    @projectAll.each do |projects|
      @projectAll_selection<<[projects.name, projects.id]
    end
    #eddig  nem kell
    @project = Project.find(params[:id])
    @versions_selection=[]

    @project.versions.each do |version|
      @versions_selection<<[version.name,version.id]
    end

    @tracker = Tracker.all
    @trackers_selection=[]

    @tracker.each do |tracker|
      @trackers_selection<<[tracker.name,tracker.id]
    end


  end

  def report
    require 'date'
    datas=Array.new
    @project = Project.find(params[:id])
    datas=Array.new
    if params.key?(:versions)
      sprints=Version.find(params[:versions])
    else
      sprints=@project.versions
    end
    if params.key?(:trackers)
      trackers=Tracker.find(params[:trackers])
    else
      trackers=@project.trackers.to_enum
    end
    #counting start data for filtering
    start_date=Issue.where(
      project_id: @project.id
    ).where(
      fixed_version_id: sprints.map{|f| f.id}
    ).where(
      tracker_id: trackers.map{|f| f.id}
    ).order(:start_date).first.start_date
    #countin end date for fitering
    end_date=sprints.sort_by{|e| e[:due_date]}.reverse.first.due_date
    if end_date>=Date.today
      end_date=Date.today
    end
    #filtering
    issues=Issue.where("start_date>= :start AND start_date<= :end AND project_id= :p_id",{
      start: start_date,
      end: end_date,
      p_id: @project.id
    }).where(
        tracker_id: trackers.map{|f| f.id}
    ).where(fixed_version_id: sprints.map{|f| f.id})
       
    #datamaking
    (start_date..end_date).each do |date|
      newItem=EstimatedData.new(date,0,0,0);
      
      issues.each do |issue|
        if !issue.closed_on || issue.closed_on>=date
            entries=TimeEntry.where("spent_on=:dd AND issue_id=:i_id",{
                dd: date,
                i_id: issue.id
            })
            spentOnIssue=0
            entries.each do |entry|
              spentOnIssue+=entry.hours
              newItem.factSum+=entry.hours
            end
            newItem.estimatedSum+=issue.estimated_hours
            newItem.leftSum+=issue.estimated_hours-spentOnIssue
        end
      end
      datas<<newItem
      ###puts "#{@project.name} datum: #{newItem.date}, becsult: #{newItem.estimatedSum}, teny: #{newItem.factSum}, es... #{newItem.leftSum}"
    end
    @dataToShow = DataStructure.new(datas,sprints.map{|f| f.name},@project.name)
  end
end
