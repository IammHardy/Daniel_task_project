class AddNameAndSectorToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :name, :string unless column_exists?(:users, :name)
    add_reference :users, :sector, foreign_key: true unless column_exists?(:users, :sector_id)
  end
end