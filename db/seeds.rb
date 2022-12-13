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

avatars = []
4.times do
  avatar_url = Faker::Avatar.image
  avatars << avatar_url
end

admin_user = User.create!(name: "Ned Kamburov", password: "Pass@123", email: "nedkamburov@example.com", role: 'admin', confirmed_at: Time.now)
admin_user.avatar.attach(io: URI.open(avatars[0]), filename: 'admin_user_avatar')

3.times do|i|
  name =  Faker::FunnyName.name
  email = "#{name.split.first}.#{name.split.last}@#{Faker::Internet.domain_name}"

  new_user = User.create!(name: name, password: "Pass@123", email: email, confirmed_at: Time.now)
  new_user.avatar.attach(io: URI.open(avatars[i+1]), filename: "#{name.split.last}_avatar")
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

Subcategory.find_by(title: 'AFC East').teams.create(title: 'Chicago')


#
# Create articles
#

articles = [
   {headline: "Lions owner expresses support for HC Dan Campbell, GM Brad Holmes following 1-5 start",
   caption: "Itching to watch an underdog try to overcome the odds or triumph against adversity?",
   content: "Lions owner Sheila Ford Hamp said Wednesday that she still believes in the leadership of head coach Dan Campbell and general manager Brad Holmes despite Detroit's slow start to the season, and that neither man's job is on the line. \nWhile Hamp told reporters that she relates to the frustration felt amongst the fanbase at the team's 1-5 start, she knows that systemic change takes time, and it wouldn't do anyone any good to be hasty with replacing people.",
   picture: 'https://static.www.nfl.com/image/private/t_editorial_landscape_12_desktop/league/adbl0xyfjjvazdyfisnj',
   picture_alt: 'Lions-owner-picture',
   category: Category.find_by(title: "NFL"),
   subcategory: Subcategory.find_by(title: "AFC West"),
   team: Team.find_by(title: "Houston"),
   is_part_of_main_articles: true,
   is_part_of_breakdown: true
   },
   {headline: "NFL Week 8 underdogs: Can injury-stricken Jets best Pats? Will Taylor Heinicke's Commanders win again?",
   caption: "Simply looking to pass the time reading another NFL.com article while stuck in your cube?",
   content: "Oh look, it's another week with both New York teams -- despite their sustained success -- not being favored in their respective matchups. \nLike last week, I'm not letting the oddsmakers dissuade me. I believe in the Giants and Jets. \nThe latter team has run into some unfortunate adversity, losing rookie standout Breece Hall to a season-ending knee injury and second-year offensive lineman Alijah Vera-Tucker to a torn triceps. But this team seems to have permanently shifted from a squad that hopes to contend to one that truly believes it can play with anyone each week. \nA young, hungry team filled with confidence can be a dangerous one. That's true of both New York clubs (and don't even get me started on the Bills, who have combined with the Jets and Giants to post the best win percentage for New York-area teams in the Super Bowl era). The city that never sleeps is stocked with two teams that should continue to feast.",
   picture: 'https://static.www.nfl.com/image/private/t_editorial_landscape_12_desktop/league/iylhn2rlt2ax4sz7406o',
   picture_alt: 'Taylor-Heinicker-jets-pats-picture',
   category: Category.find_by(title: "NFL"),
   subcategory: Subcategory.find_by(title: "AFC West"),
   team: Team.find_by(title: "Memphis"),
   is_part_of_main_articles: true,
   is_part_of_breakdown: true
   },
   {headline: "Mike Tomlin not ready to make changes to struggling Steelers offense: 'I don't feel like I'm there'",
   caption: "Tomlin will continue down the charted course for the time being.",
   content: "The Pittsburgh Steelers offense has been atrocious for most of the season, ranking 31st with 15.3 points per game in 2022, 30th in total yards per game, tied for 27th in turnovers and dead-last in passer rating heading into Week 8. \nThe quarterback change from Mitchell Trubisky to Kenny Pickett didn't significantly jumpstart the offense. But coach Mike Tomlin said Tuesday he's not ready to make more changes with his starters or coaching staff -- despite calls for offensive coordinator Matt Canada's job growing louder by the week.",
   picture: 'https://static.www.nfl.com/image/private/t_editorial_landscape_12_desktop/league/h5cpkr3drmfrjkwcgfor',
   picture_alt: 'Mike-Tomlin-picture',
   category: Category.find_by(title: "NFL"),
   subcategory: Subcategory.find_by(title: "AFC West"),
   team: Team.find_by(title: "Utah Jazz"),
   is_part_of_main_articles: true
   },
   {headline: "Bears QB Justin Fields dealing with left shoulder dislocation",
    caption: "Chicago quarterback Justin Fields is dealing with a left shoulder dislocation",
    content: "Earlier in the day, Bears head coach Matt Eberflus announced that his dual-threat QB was day to day and Rapoport noted Fields' status for Week 12 against the New York Jets is still to be determined. Thus, there's more clarity on what Fields' ailment is, but no more on his availability. \nFields was also dealing with hamstring tightness on Sunday and though he did not miss any plays against the Falcons, was carted from the sideline to the locker room to get looked at.Just how much -- if any -- time Fields misses offers a wide spectrum of outcomes with a shoulder separation, which somewhat explains why Eberflus said on Monday that Fields was day to day, but would also not rule out it being a season-ending injury. Another factor is the physical toll the second-year QB is taking on his body week after week as the Bears are just 3-8.",
    picture: 'https://static.www.nfl.com/image/private/t_editorial_landscape_12_desktop/f_auto/league/hfpumxhssgpapjiifpum.jpg',
    picture_alt: 'Bears-QB-Justin-Fields-picture',
    category: Category.find_by(title: "NFL"),
    subcategory: Subcategory.find_by(title: "AFC East"),
    team: Team.find_by(title: "Chicago")
   }]

articles.each do |article|
  new_article = Article.create!(headline: article[:headline],
                                caption: article[:caption],
                                content: article[:content],
                                picture_alt: article[:picture_alt],
                                category: article[:category],
                                subcategory: article[:subcategory],
                                team: article[:team],
                                is_part_of_main_articles: article[:is_part_of_main_articles],
                                is_part_of_breakdown: article[:is_part_of_breakdown]
  )
  remote_picture = URI.open(article[:picture])
  new_article.picture.attach(io: remote_picture, filename: article[:picture_alt])
end
puts 'Articles have been added to each team from the AFC West subcategory!'

comments = [
  {content: "Great game!",
    user: User.all[0],
    article: Article.all[0]
  },
  {content: "What a waste of time!!!",
   user: User.all[1],
   article: Article.all[1]
  },
  {content: "Good game, boys!",
   user: User.all[0],
   article: Article.all[1]
  },
  {content: "REFERREEEE!!",
   user: User.all[2],
   article: Article.all[2]
  },
  {content: "A joy to watch the game in November. Ahhh ^_^",
   user: User.all[1],
   article: Article.all[2]
  }]

comments.each do |comment|
  Comment.create!(content: comment[:content], user: comment[:user], article: comment[:article])
end
4.times do |i|
  Comment.create!(content: comments[i][:content], user:  comments[i][:user], article:  comments[2][:article])
end
puts 'Several comments have been added to each article from the AFC West subcategory!'

Like.create!(user: User.all[0], likeable: Comment.all[0])
Like.create!(user: User.all[1], likeable: Comment.all[0])
Like.create!(user: User.all[0], likeable: Comment.all[1])
Like.create!(user: User.all[1], likeable: Comment.all[1])
Like.create!(user: User.all[3], likeable: Comment.all[2])
puts 'Likes have been added to several comments from the AFC West subcategory!'

Newsletter.create!(name: User.last.name, email: User.last.email)
puts 'The last user is added to the newsletter mailing list.'

FooterPage.create!(title: 'About Sports Hub', url: "#", page_type: 'Company Info', status: 'shown')
FooterPage.create!(title: 'News / In the Press', url: "#", page_type: 'Company Info', status: 'shown')
FooterPage.create!(title: 'Advertising / Sports Blogger Ad Network', url: "#", page_type: 'Company Info', status: 'shown')
FooterPage.create!(title: 'Events', url: "#", page_type: 'Company Info', status: 'hidden')
FooterPage.create!(title: 'Contact Us', url: "#", page_type: 'Company Info', status: 'shown')

FooterPage.create!(title: 'Featured Writers Program', url: "#", page_type: 'Contributors', status: 'shown')
FooterPage.create!(title: 'Featured Team Writers Program', url: "#", page_type: 'Contributors', status: 'shown')
FooterPage.create!(title: 'Internship Program', url: "#", page_type: 'Contributors', status: 'shown')

FooterPage.create!(title: 'Sign up to receive the latest sports news', url: "#", page_type: 'Newsletter', status: 'shown')
puts 'All footer pages were created.'

photo_of_the_day = PhotoOfTheDay.create!(picture_alt: 'photo-of-the-day', title: 'Jockeys compete in the Melbourne Cup in Melbourne, Australia.', description: 'This “race that stops a nation” is run at the Flemington Racecourse on the first Tuesday in November. The public holiday in Melbourne ensures that Victoria’s society—both high and low—is on hand along with the thoroughbreds.', author: 'Andrew Brwonbill, AP')
remote_picture = URI.open('https://i.natgeofe.com/n/b2432c41-1636-426e-8133-cb46316f87e0/83238_16x9.jpg?w=1200')
photo_of_the_day.picture.attach(io: remote_picture, filename: 'photo_of_the_day-horse_racing')
puts 'Photo of the day was created.'