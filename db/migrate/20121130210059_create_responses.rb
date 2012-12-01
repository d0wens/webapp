class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.references :answer
      t.references :user
      t.references :question
      t.text :content

      t.timestamps
    end
    add_index :responses, :answer_id
    add_index :responses, :user_id
    add_index :responses, :question_id
  end
end
