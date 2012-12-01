class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :assignment_id
      t.text :content
      t.boolean :anonymous, default: false
      t.boolean :allow_free_response, default: false
      t.integer :points

      t.timestamps
    end
  end
end
