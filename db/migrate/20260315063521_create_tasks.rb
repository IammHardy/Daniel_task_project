class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.integer :status
      t.integer :priority
      t.date :due_date
      t.integer :progress
      t.references :manager, foreign_key: { to_table: :users }
      t.references :employee, foreign_key: { to_table: :users }
      t.references :sector, null: false, foreign_key: true

      t.timestamps
    end
  end
end
