class AddLimitColumnToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :limit, :date
  end
end
