class CreateDataItem < ActiveRecord::Migration
  def change
    create_table :data_item do |t|
      t.string :user
      t.datetime :date
      t.integer :sprints
      t.timestamps
    end
  end
end