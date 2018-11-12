# noinspection RubyResolve,RubyClassModuleNamingConvention
class CreateDemoIssues < ActiveRecord::Migration

  def self.up
    Issue.create!([
                      {
                          :author => User.find_by(login: "demo"),
                          :project => Project.find_by(identifier: "agile"),
                          :tracker => Tracker.find_by(:id => "2"),
                          :assigned_to => User.find_by(login: "demo"),
                          :subject => "DemoIssue1"
                      },
                      {
                          :author => User.find_by(login: "demo"),
                          :project => Project.find_by(identifier: "agile"),
                          :tracker => Tracker.find_by(:id => "2"),
                          :assigned_to => User.find_by(login: "demo"),
                          :subject => "DemoIssue2"
                      },
                      {
                          :author => User.find_by(login: "demo"),
                          :project => Project.find_by(identifier: "agile"),
                          :tracker => Tracker.find_by(:id => "2"),
                          :assigned_to => User.find_by(login: "demo"),
                          :subject => "DemoIssue3"
                      },
                      {
                          :author => User.find_by(login: "demo"),
                          :project => Project.find_by(identifier: "agile"),
                          :tracker => Tracker.find_by(:id => "2"),
                          :assigned_to => User.find_by(login: "demo"),
                          :subject => "DemoIssue4"
                      },

                  ])

  end

  def self.down
    Issue.destroy_all(author: "demo")
  end
end
