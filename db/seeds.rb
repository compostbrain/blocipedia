# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'random_data'

# Create Wikis
50.times do
  Wiki.create!(
    title: Faker::Book.title,
    body: Faker::Lorem.paragraphs(3, true),
    private: true
  )
end
50.times do
  Wiki.create!(
    title: Faker::Book.title,
    body: Faker::Lorem.paragraphs(3, true),
    private: false
  )
end
wikis = Wiki.all





puts 'Seed finished'
puts "#{Wiki.count} wikis created"
