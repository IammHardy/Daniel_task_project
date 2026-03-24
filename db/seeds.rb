# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb

company = Company.first || Company.create!(name: "Test Company")
sector = Sector.first || Sector.create!(name: "General", company: company)
manager = User.find_or_create_by!(email: "manager@test.com") do |u|
  u.name = "Test Manager"
  u.password = u.password_confirmation = "password"
  u.role = :manager
  u.company_id = company.id
end
employee = User.find_or_create_by!(email: "employee@test.com") do |u|
  u.name = "Test Employee"
  u.password = u.password_confirmation = "password"
  u.role = :employee
  u.company_id = company.id
  u.manager_id = manager.id
  u.sector_id = sector.id
end
Task.find_or_create_by!(title: "Test Task", employee: employee) do |t|
  t.description = "Sample task"
  t.manager = manager
  t.sector = sector
  t.company = company
end