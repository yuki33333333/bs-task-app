class AddColumnToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :limit, :date
    add_column :tasks, :priority, :int
    add_column :tasks, :user_id, :int
  end
end
