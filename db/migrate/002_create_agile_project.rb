# noinspection RubyResolve,RubyClassModuleNamingConvention
class CreateAgileProject < ActiveRecord::Migration

  def self.down
    delete_project
    delete_version
  end

  def self.up
    create_project
    create_version
  end

  def self.create_project
    Project.create!(
        name: "Agilis",
        identifier: "agile",
        is_public: false,
        inherit_members: false,
        enabled_module_names: ["issue_tracking", "time_tracking", "news", "documents", "files", "wiki", "repository", "boards", "calendar", "gantt"])
  end

  def self.delete_project
    Project.destroy_all(identifier: "agile")
  end

  def self.create_version
    Version.create!(
               project_id: Project.find_by(identifier: "agile").id,
               name: "Sprint 1",
               effective_date: Date.new(2018,12, 20),
               status: "open",
               sharing: "tree"
    )
  end
def self.delete_version
    Version.destroy_all(name: "Sprint 1")
  end


end
