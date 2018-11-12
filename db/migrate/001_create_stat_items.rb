class CreateStatItems < ActiveRecord::Migration
  def change
    create_table :stat_items do |t|

      t.datetime :date

      t.integer :remaining_work_hours

      t.integer :remaining_issue_hours

      t.integer :remaining_issue_hours

    end

  end
end
