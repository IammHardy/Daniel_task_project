class AddDefaultsToTasks < ActiveRecord::Migration[8.0]
  def change
    change_column_default :tasks, :status, 0
    change_column_default :tasks, :priority, 1
    change_column_default :tasks, :progress, 0
  end
end