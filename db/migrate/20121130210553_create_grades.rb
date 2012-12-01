class CreateGrades < ActiveRecord::Migration
  def change
    create_table :grades do |t|
      t.references :user
      t.references :assignment
      t.references :course
      t.integer :grade

      t.timestamps
    end
    add_index :grades, :user_id
    add_index :grades, :assignment_id
    add_index :grades, :course_id
  end
end
