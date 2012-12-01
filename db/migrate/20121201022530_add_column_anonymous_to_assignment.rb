class AddColumnAnonymousToAssignment < ActiveRecord::Migration
  def change
    add_column :assignments, :anonymous, :boolean, default: false
  end
end
