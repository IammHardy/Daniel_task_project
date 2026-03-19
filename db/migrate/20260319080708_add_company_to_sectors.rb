class AddCompanyToSectors < ActiveRecord::Migration[8.0]
  def change
    add_reference :sectors, :company, null: false, foreign_key: true
  end
end