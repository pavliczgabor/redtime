class RedtimeMainController < ApplicationController
  def index
    @project = Project.find(params[:id])
    @versions_selection=[]
    @project.versions.each do |version|
      @versions_selection<<[version.name,version.id]
    end
    @users_selection=[]
    @project.users.each do |user|
      @users_selection<<[user.login,user.id]
    end
  end
  def time_report
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
      users=@project.users
    end
    if params.key?(:dates)
      start_date=params[:dates][:start_date]
      end_date=params[:dates][:end_date]

      entries=TimeEntry.joins(:issue).where("time_entries.created_on >= :start AND time_entries.created_on <= :end AND time_entries.project_id = :p_id",{
          start: start_date,
          end: end_date,
          p_id: @project.id
      }).where(
            user_id: users.map{|f| f.id}
      ).where(issues:{fixed_version_id: sprints.map{|f| f.id}}).order('time_entries.user_id,time_entries.created_on')
      user_id=nil
      day=nil
      sprint_indexes=sprints.map{|f| f.id}.zip(Array(0..sprints.length-1)).to_h
      user_times_on_day=Array.new(sprints.length,0)
      entries.each do |entry|
        if entry.created_on.to_date!=day || entry.user_id!=user_id
          if day and user_id
            datas<<DataItem.new(users.find(id: user_id).first.login,day,user_times_on_day)
          end
          user_id=entry.user_id
          day=entry.created_on.to_date
          user_times_on_day=Array.new(sprints.length,0)
        end
        user_times_on_day[sprint_indexes[entry.issue.fixed_version_id]]+=entry.hours
      end
      if day and user_id
        datas<<DataItem.new(users.find(id: user_id).first.login,day,user_times_on_day)
      end
    end
    @dataToShow = DataStructure.new(datas,sprints.map{|f| f.name},"valami")
  end
end
