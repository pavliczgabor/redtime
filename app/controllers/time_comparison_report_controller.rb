class TimeComparisonReportController < ApplicationController
  def filter

    @projectAll = Project.all
    @projectAll_selection=[]

    @projectAll.each do |projects|
      @projectAll_selection<<[projects.name, projects.id]
    end

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
    @project = Project.find(params[:id])
    datas=Array.new
    if params.key?(:versions)
      sprints=Version.find(params[:versions])
    else
      sprints=@project.versions
    end
    if params.key?(:users)
      users=User.find(params[:users])
    else
      users=@project.users.to_enum
    end
  end
end
