class AddIndexesToTasks < ActiveRecord::Migration[8.0]
  def change
    add_index :tasks, [:employee_id, :status]
    add_index :tasks, [:manager_id, :status]
  end
end