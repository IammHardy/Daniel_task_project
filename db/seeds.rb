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

# Create default company
company = Company.find_or_create_by!(name: "Default Company")

# Create default sector
sector = Sector.find_or_create_by!(name: "Default Sector")

# Create admin user
User.find_or_create_by!(email: "admin@example.com") do |user|
  user.password = "password123"
  user.password_confirmation = "password123"
  user.name = "Admin User"
  user.role = :admin
  user.company = company
  user.sector = sector
end

puts "✅ Admin user created: admin@example.com / password123"