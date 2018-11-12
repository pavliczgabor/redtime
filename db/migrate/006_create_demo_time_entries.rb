# noinspection RubyResolve,RubyClassModuleNamingConvention
class CreateDemoTimeEntries < ActiveRecord::Migration

  def self.up
    TimeEntry.create!([
                          {
                              :user => User.find_by(login: "demo"),
                              :project => Project.find_by(identifier: "agile"),
                              :issue => Issue.find_by(:subject => "DemoIssue1"),
                              :hours => 1,
                              :activity_id => 9,
                              :spent_on => Date.new(2018, 10, 30)
                          },
                          {
                              :user => User.find_by(login: "demo"),
                              :project => Project.find_by(identifier: "agile"),
                              :issue => Issue.find_by(:subject => "DemoIssue2"),
                              :hours => 2,
                              :activity_id => 9,
                              :spent_on => Date.new(2018, 10, 31)
                          },
                          {
                              :user => User.find_by(login: "demo"),
                              :project => Project.find_by(identifier: "agile"),
                              :issue => Issue.find_by(:subject => "DemoIssue3"),
                              :hours => 4,
                              :activity_id => 9,
                              :spent_on => Date.new(2018, 10, 28)
                          },
                          {
                              :user => User.find_by(login: "demo"),
                              :project => Project.find_by(identifier: "agile"),
                              :issue => Issue.find_by(:subject => "DemoIssue2"),
                              :hours => 7,
                              :activity_id => 9,
                              :spent_on => Date.new(2018, 10, 28)
                          },
                          {
                              :user => User.find_by(login: "demo"),
                              :project => Project.find_by(identifier: "agile"),
                              :issue => Issue.find_by(:subject => "DemoIssue1"),
                              :hours => 0.5,
                              :activity_id => 9,
                              :spent_on => Date.new(2018, 10, 29)
                          },
                          {
                              :user => User.find_by(login: "demo"),
                              :project => Project.find_by(identifier: "agile"),
                              :issue => Issue.find_by(:subject => "DemoIssue2"),
                              :hours => 2,
                              :activity_id => 9,
                              :spent_on => Date.new(2018, 10, 30)
                          }
                      ])

  end

  def self.down
    TimeEntry.destroy_all(user_id: "demo")
  end
end
