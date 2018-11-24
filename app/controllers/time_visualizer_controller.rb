class TimeVisualizerController < ApplicationController

  def index
    @project = Project.find(params[:id])
    @sprints_selection = []
    get_sprints_selection()


    @trackers_selection = []
    get_trackers_selection()

    @sprints = get_sprints()
    @trackers = get_trackers()

    calculate_graph()
  end

  #relevans sprintek kivalasztasa
  def get_sprints
    if params.key?(:sprints)
      @sprints = Version.where(id: params[:sprints]).order(:created_on)
    else
      @sprints = @project.versions.order(:created_on)
    end
  end

 #szukseges trackerek kivalasztasa
  def get_trackers
    if (params.key?(:trackers))
      @trackers = Tracker.find(params[:trackers])
    else
      @trackers = @project.trackers
    end
  end

  #sprintek nevenek es id-jenek kiszurese
  def get_sprints_selection
    @project.versions.each do |version|
      @sprints_selection << [version.name, version.id]
    end
    @sprints_selection.sort
  end

  #trackerek nevenek es id-jenek kiszurese
  def get_trackers_selection
    @project.trackers.each do |tracker|
      @trackers_selection << [tracker.name, tracker.id]
    end
  end

  # @dataItems feltoltese valós adatokkal
  def calculate_graph
    @dataItems = []

    #TODO: dokumentacio ir szurest a "projekthez rendelt megadott szerepkoru felhasznalora" is
    issues = Issue.where(fixed_version: @sprints, tracker: @trackers)
    time_entries = TimeEntry.where(issue: issues)
    journals = Journal.where(journalized: issues)
    journal_details = JournalDetail.where(journal: journals) if !journals.empty?
    work_hour_per_week = 0
    @project.members.each do |member|
      work_hour_per_week += member.user.custom_field_value(UserCustomField.find_by(name: "Munkaóra/Hét").id).to_i
    end
    start_date = @sprints.first.created_on.to_date
    end_date = @sprints.last.effective_date.to_date
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
  end

end
