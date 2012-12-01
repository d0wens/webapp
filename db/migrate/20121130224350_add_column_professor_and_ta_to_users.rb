class AddColumnProfessorAndTaToUsers < ActiveRecord::Migration
  def change
    add_column :users, :professor, :boolean, default: false
	add_column :users, :ta, :boolean, default: false
  end
end
