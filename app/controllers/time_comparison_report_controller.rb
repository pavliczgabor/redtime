class TimeComparisonReportController < ApplicationController
  def filter
    @project = Project.find(params[:id])
  end
  def report
    @project = Project.find(params[:id])
  end
end
