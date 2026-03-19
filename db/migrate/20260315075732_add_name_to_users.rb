class AddNameToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :name, :string unless column_exists?(:users, :name)
  end
end