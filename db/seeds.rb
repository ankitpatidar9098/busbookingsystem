# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

for i in 1..10
     Route.create(from:"city#{i}",to:"city#{i+1}")
end
if Rails.env.development?
	AdminUser.create!(email: 'ankittt@gmail.com', password: 'password', password_confirmation: 'password')
end