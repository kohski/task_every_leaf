# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

50.times do
  Task.create(
    name:Faker::Food.dish,
    content:Faker::Food.description,
    expired_at: DateTime.now + rand(1..4),
    status:rand(0..2),
    priority: rand(0..2)
  )
end