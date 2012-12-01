class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :course_name
      t.string :semester
      t.integer :user_id

      t.timestamps
    end
	add_index :courses, [:course_name, :semester, :user_id]
  end
end
