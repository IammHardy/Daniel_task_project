class AddCompanyToTasks < ActiveRecord::Migration[8.0]
  def change
    add_reference :tasks, :company, null: false, foreign_key: true
  end
end
