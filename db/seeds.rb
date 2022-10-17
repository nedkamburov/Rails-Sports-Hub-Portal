# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

#
# Create users
#
require 'faker'
User.create!(name: "Ned Kamburov", password: "Pass@123", email: "nkamb@softserveinc.com", role: 'admin')

3.times do
  name =  Faker::FunnyName.name
  email = "#{name.split.first}.#{name.split.last}@#{Faker::Internet.domain_name}"

  User.create!(name: name, password: "Pass@123", email: email)
end
puts '4 Users created successfully! Access them with password: Pass@123'

#
# Create categories and subcategories
#

STATIC_PAGES = ['Home', 'News', 'Team hub', 'Lifestyle', 'Dealbook', 'Video']
STATIC_PAGES.each do |page|
  Category.create!(title: page)
end
puts 'All static pages created!'

SPORTS = ['NFL', 'NBA', 'NHL', 'CFB', 'Nascar', 'Golf', 'Soccer']
SPORTS.each do |sport|
  Category.create!(title: sport, parent_category: Category.find_by(title: 'News'))
end
puts 'Several sport categories created!'

SPORTS_SUBCATEGORIES = ['AFC East', 'AFC North', 'AFC South']
SPORTS_SUBCATEGORIES.each do |sport_subcategory|
  Category.create!(title: sport_subcategory, parent_category: Category.find_by(title: 'NFL') )
end
puts 'Subcategories added to the NFL Category!'
