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
require 'ostruct'
require 'open-uri'
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

#
# Create articles
#

articles = [
  OpenStruct.new(
   {headline: "Lions owner expresses support for HC Dan Campbell, GM Brad Holmes following 1-5 start",
   caption: "Itching to watch an underdog try to overcome the odds or triumph against adversity?",
   content: "Lions owner Sheila Ford Hamp said Wednesday that she still believes in the leadership of head coach Dan Campbell and general manager Brad Holmes despite Detroit's slow start to the season, and that neither man's job is on the line. \nWhile Hamp told reporters that she relates to the frustration felt amongst the fanbase at the team's 1-5 start, she knows that systemic change takes time, and it wouldn't do anyone any good to be hasty with replacing people.",
   picture: 'https://static.www.nfl.com/image/private/t_editorial_landscape_12_desktop/league/adbl0xyfjjvazdyfisnj',
   picture_alt: 'Lions-owner-picture',
   category: Category.find_by(title: "NFL"),
   team: Team.find_by(title: "Houston")}),
  OpenStruct.new(
   {headline: "NFL Week 8 underdogs: Can injury-stricken Jets best Pats? Will Taylor Heinicke's Commanders win again?",
   caption: "Simply looking to pass the time reading another NFL.com article while stuck in your cube?",
   content: "Oh look, it's another week with both New York teams -- despite their sustained success -- not being favored in their respective matchups. \nLike last week, I'm not letting the oddsmakers dissuade me. I believe in the Giants and Jets. \nThe latter team has run into some unfortunate adversity, losing rookie standout Breece Hall to a season-ending knee injury and second-year offensive lineman Alijah Vera-Tucker to a torn triceps. But this team seems to have permanently shifted from a squad that hopes to contend to one that truly believes it can play with anyone each week. \nA young, hungry team filled with confidence can be a dangerous one. That's true of both New York clubs (and don't even get me started on the Bills, who have combined with the Jets and Giants to post the best win percentage for New York-area teams in the Super Bowl era). The city that never sleeps is stocked with two teams that should continue to feast.",
   picture: 'https://static.www.nfl.com/image/private/t_editorial_landscape_12_desktop/league/iylhn2rlt2ax4sz7406o',
   picture_alt: 'Taylor-Heinicker-jets-pats-picture',
   category: Category.find_by(title: "NFL"),
   team: Team.find_by(title: "Memphis")}),
  OpenStruct.new(
  {headline: "Mike Tomlin not ready to make changes to struggling Steelers offense: 'I don't feel like I'm there'",
   caption: "Tomlin will continue down the charted course for the time being.",
   content: "The Pittsburgh Steelers offense has been atrocious for most of the season, ranking 31st with 15.3 points per game in 2022, 30th in total yards per game, tied for 27th in turnovers and dead-last in passer rating heading into Week 8. \nThe quarterback change from Mitchell Trubisky to Kenny Pickett didn't significantly jumpstart the offense. But coach Mike Tomlin said Tuesday he's not ready to make more changes with his starters or coaching staff -- despite calls for offensive coordinator Matt Canada's job growing louder by the week.",
   picture: 'https://static.www.nfl.com/image/private/t_editorial_landscape_12_desktop/league/h5cpkr3drmfrjkwcgfor',
   picture_alt: 'Mike-Tomlin-picture',
   category: Category.find_by(title: "NFL"),
   team: Team.find_by(title: "Utah Jazz")})
]


articles.each do |article|
  new_article = Article.create!(headline: article.headline, caption: article.caption, content: article.content, picture_alt: article.picture_alt, category: article.category, team: article.team)

  remote_picture = URI.open(article.picture)
  new_article.picture.attach(io: remote_picture, filename: article.picture_alt)
end
puts 'Articles have been added to each team from the AFC West subcategory!'