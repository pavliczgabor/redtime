class TimeVisualizerController < ApplicationController

  def index
    @project = Project.find(params[:id])
    @sprints_selection = []
    @project.versions.each do |version|
      @sprints_selection << [version.name, version.id]
    end
    @sprints_selection.sort

    @trackers_selection = []
    @project.trackers.each do |tracker|
      @trackers_selection << [tracker.name, tracker.id]
    end

    #Szűrés az adott paraméterekkel.
    @dataItems = []
    if params.key?(:sprints)
      sprints = Version.where(id: params[:sprints]).order(:created_on)
    else
      sprints = @project.versions.order(:created_on)
    end

    if (params.key?(:trackers))
      trackers = Tracker.find(params[:trackers])
    else
      trackers = @project.trackers
    end
    #megadott sprint(ek) és tracker(ek)0
    sprint_names = sprints.map {|f| f.name}
    tracker_names = trackers.map {|f| f.name}
    #TODO: dokumentacio ir szurest a "projekthez rendelt megadott szerepkoru felhasznalora" is

    # @dataItems feltoltese valós adatokkal
    issues = Issue.where(fixed_version: sprints, tracker: trackers)
    time_entries = TimeEntry.where(issue: issues)
    journals = Journal.where(journalized: issues)
    journal_details = JournalDetail.where(journal: journals) if !journals.empty? 
    work_hour_per_week = 0
    @project.members.each do |member|
      work_hour_per_week += member.user.custom_field_value(UserCustomField.find_by(name: "Munkaóra/Hét").id).to_i
    end
    start_date = sprints.first.created_on.to_date
    end_date = sprints.last.effective_date.to_date
    issue_hours = 0
    added_issues = []
    added_time_entires = []
    for date in start_date..end_date
      work_days = (end_date - date).to_f
      issues.each do |issue|
        if issue.created_on.to_date <= date
          if !added_issues.find {|is| is[:issue] == issue}.present?
            added_issues << {:issue => issue, :time_left => issue.estimated_hours || 0, :finished => false}
            issue_hours += issue.estimated_hours || 0
          end
          time_entries.where(issue: issue).each do |te|
            if !added_time_entires.include?(te) && te.spent_on <= date && !added_issues.find {|is| is[:issue] == issue}[:finished]
              added_time_entires << te
              issue_hours -= te.hours
              puts "kiscica"
              puts added_issues.find {|is| is[:issue] == issue}[:time_left].class
              added_issues.find {|is| is[:issue] == issue}[:time_left] -= te.hours
            end
          end
        end
        if !journals.empty?
          journals.where(journalized: issue).each do |jo|
            if jo.created_on.to_date == date && !journal_details.where(journal: jo, prop_key: "status_id", old_value: %w[1 2], value: "3").empty? &&
                added_issues.find {|is| is[:issue] == issue}[:time_left] > 0
              issue_hours -= added_issues.find {|is| is[:issue] == issue}[:time_left]
              added_issues.find {|is| is[:issue] == issue}[:time_left] = 0
              added_issues.find {|is| is[:issue] == issue}[:finished] = true
            end
          end
        end
      end
      @dataItems << StatItem.new(1, "valami", {date => {:remaining_work_hour => ((work_days / 7.0) * work_hour_per_week).to_i, :remaining_issue_hour => issue_hours}})
    end
    # @dataItems feltoltese dummy adatokkal

    #@dataItems << StatItem.new(sprints.map{|f| f.name},trackers.map{|f| f.name}, {Date.new(2018,5, 20) => {:remaining_work_hour => 220, :remaining_issue_hour => 150 }})
    # @dataItems << StatItem.new(0.1,"Feladat", {Date.new(2018,5, 20) => {:remaining_work_hour => 220, :remaining_issue_hour => 150 }})
    # @dataItems << StatItem.new(0.1,"Hiba", {Date.new(2018,5, 21) => {:remaining_work_hour => 180, :remaining_issue_hour => 150 }})
    # @dataItems << StatItem.new(0.1,"Feladat", {Date.new(2018,5, 22) => {:remaining_work_hour => 100, :remaining_issue_hour => 90 }})
    # @dataItems << StatItem.new(0.1,"Feladat", {Date.new(2018,5, 25) => {:remaining_work_hour => 50, :remaining_issue_hour => 40 }})
    # @dataItems << StatItem.new(0.1,"Feladat", {Date.new(2018,5, 28) => {:remaining_work_hour => 30, :remaining_issue_hour => 20 }})
  end

end
