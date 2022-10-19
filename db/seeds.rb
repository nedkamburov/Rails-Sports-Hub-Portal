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
# Create categories, subcategories and teams
#

STATIC_PAGES = ['Lifestyle', 'Dealbook', 'Video']
SPORTS = ['NFL', 'NBA', 'NHL', 'CFB', 'Nascar', 'Golf', 'Soccer']

Category.create!(title: STATIC_PAGES[0], position: SPORTS.length + 0, read_only: true, category_type: 'general')
Category.create!(title: STATIC_PAGES[1], position: SPORTS.length + 1, read_only: true, category_type: 'general')
Category.create!(title: STATIC_PAGES[2], position: SPORTS.length + 2, read_only: true, category_type: 'videos')
puts 'All static pages created!'

SPORTS.each_with_index do |sport, i|
  Category.create!(title: sport, position: i, read_only: false, category_type: 'articles')
end
puts 'Several sport categories created!'

SPORTS_SUBCATEGORIES = ['AFC East', 'AFC North', 'AFC South', 'AFC West']
NFL_CATEGORY = Category.find_by(title: 'NFL')
SPORTS_SUBCATEGORIES.each do |subcategory|
  NFL_CATEGORY.subcategories.create(title: subcategory)
end
puts 'Subcategories added to the NFL category!'

SPORTS_TEAMS = ['Houston', 'Memphis', 'Utah Jazz']
AFC_WEST_SUBCATEGORY = Subcategory.find_by(title: 'AFC West')
SPORTS_TEAMS.each do |team|
  AFC_WEST_SUBCATEGORY.teams.create(title: team)
end
puts 'Teams added to the AFC West subcategory (part of the NFL category)!'
