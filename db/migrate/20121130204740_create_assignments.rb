class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.string :name
      t.boolean :published, default: false
      t.datetime :due_date
      t.integer :total_points

      t.timestamps
    end
  end
end
