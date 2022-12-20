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
SPORTS = ['NFL', 'NBA', 'NHL', 'NASCAR', 'Golf', 'Football']

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

NBA_CATEGORY = Category.find_by(title: 'NBA')
NBA_CATEGORY.subcategories.create(title: 'Chicago')
NHL_CATEGORY = Category.find_by(title: 'NHL')
NHL_CATEGORY.subcategories.create(title: 'Montreal')
NASCAR_CATEGORY = Category.find_by(title: 'NASCAR')
NASCAR_CATEGORY.subcategories.create(title: 'Chevrolet')
GOLF_CATEGORY = Category.find_by(title: 'Golf')
GOLF_CATEGORY.subcategories.create(title: 'Florida')
FOOTBALL_CATEGORY = Category.find_by(title: 'Football')
FOOTBALL_CATEGORY.subcategories.create(title: 'England')
puts 'Subcategories added to all categories!'

SPORTS_TEAMS = ['Houston', 'Memphis', 'Utah Jazz']
AFC_WEST_SUBCATEGORY = Subcategory.find_by(title: 'AFC West')
SPORTS_TEAMS.each do |team|
  AFC_WEST_SUBCATEGORY.teams.create(title: team)
end
Subcategory.find_by(title: 'AFC East').teams.create(title: 'Chicago')

Subcategory.find_by(title: 'Chicago', category: NBA_CATEGORY).teams.create(title: 'Chicago Bulls')
Subcategory.find_by(title: 'Montreal', category: NHL_CATEGORY).teams.create(title: 'Montreal Canadiens')
Subcategory.find_by(title: 'Chevrolet', category: NASCAR_CATEGORY).teams.create(title: 'Bassett Racing')
Subcategory.find_by(title: 'Florida', category: GOLF_CATEGORY).teams.create(title: 'Florida Gators')
Subcategory.find_by(title: 'England', category: FOOTBALL_CATEGORY).teams.create(title: 'Chelsea')
puts 'Teams added to all subcategories!'

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
   },
   {headline: "Five big talking points from the action so far",
    caption: "With plenty of reasons left to continue watching as the NBA drama unfolds into the New Year",
    content: "Anything can happen\nThe Boston Celtics and the Milwaukee Bucks are vying for pole position in the Eastern Conference.\nThough it may have been a long stretch of dominance for the Celts, a recent string of defeats to the Orlando Magic, the Golden State Warriors, and the Los Angeles Clippers, proves that there are weaknesses in the supposed best team in the league.",
    picture: 'https://e0.365dm.com/22/12/1600x900/skysports-nba-boston-celtics_6000104.jpg?20221218094143',
    picture_alt: 'Jayson Tatum plays against the Orlando Magic',
    category: Category.find_by(title: "NBA"),
    subcategory: Subcategory.find_by(title: "Chicago"),
    team: Team.find_by(title: "Chicago Bulls")
   },
   {headline: "Hagel scores twice as Lightning rout Canadiens",
    caption: "Brandon Hagel realised a decisive 5-1 win over the Montreal Canadiens on Saturday",
    content: "Hagel hit a milestone with his first goal when he reached the 100-point mark in the National Hockey League. It was a feat the fifth-year pro didn’t realize was at arm’s reach.\n“I'm not even sure, maybe, I guess it was 100?” Hagel asked. “It's crazy from how it started and the ups and downs I’ve been through and finally to get that, it's pretty cool.”\nLightning head coach Jon Cooper didn’t like his team’s start Saturday at the Bell Centre but said Hagel’s goal was the kick-starter for his side.\n“That's what he's done for us, his engine’s always going and he never gives up on pucks,” Cooper said. “He's always around the net, as both those goals he scored. It's been kind of (Ondrej Palat’s) spot for a lot of years and Hagel’s fit seamlessly in there and it's been really good for us.",
    picture: 'https://www.tsn.ca/polopoly_fs/1.1894798!/fileimage/httpImage/image.jpg_gen/derivatives/landscape_980/kaiden-guhle-21-brandon-hagel-38-steven-stamkos-91-joel-edmundson-44.jpg',
    picture_alt: 'brandon-hagel-38-steven-stamkos-91-joel-edmundson-44',
    category: Category.find_by(title: "NHL"),
    subcategory: Subcategory.find_by(title: "Montreal"),
    team: Team.find_by(title: "Montreal Canadiens")
   },
   {headline: "Dillon Bassett, Bassett Racing Sporting Bright Orange Honest Amish Scheme at Atlanta",
    caption: "Bassett Racing will try to qualify for their first NASCAR Xfinity Series start at Atlanta this weekend.",
    content: "Bassett, 24, has made eight starts in the NASCAR Xfinity Series since the 2019 season. To date, Bassett’s career-best finish is 13th, which he has achieved twice, once at Richmond in 2019 and once at Charlotte Motor Speedway in 2020.\nThe Winston Salem, North Carolina-native has never made a NXS start at Atlanta Motor Speedway, but he will look to get to tackle the 1.54-mile speedway in Hampton, Georgia this weekend.\nIn addition to the primary sponsorship from Honest Amish, the No. 77 team will have associate sponsorship from Jerry Hunt Supercenter as well as Helmets to Hardhats and cryptocurrency DarToken.IO.\nIn a press release from the Bassett Racing team, the organization hinted that they will have many new sponsorship partnerships to announce for the No. 77 team in the near future.",
    picture: 'https://cdn-1.motorsport.com/images/mgl/0qX9JDO6/s1200/dillon-bassett-bassett-racing--1.webp',
    picture_alt: 'Bright, bold No. 77 Honest Amish Chevrolet Camaro at Atlanta as Bassett Racing ',
    category: Category.find_by(title: "NASCAR"),
    subcategory: Subcategory.find_by(title: "Chevrolet"),
    team: Team.find_by(title: "Bassett Racing")
   },
   {headline: "Tiger Woods and son two shots off the lead after opening round",
    caption: "'We had a blast slaying it today. All day we were after it; we didn't get off to a great start but we really got into it' - Tiger",
    content: "Tiger Woods teamed up with his son Charlie to get within two shots of the lead after the opening round of the PNC Championship in Florida.\nThe pair posted an eagle and 11 birdies during an opening-round 59 in the scramble format at Ritz-Carlton Golf Club in Orlando, where each team selects the best shot and continues to play from there until the ball is holed.\nTeam Woods, looking to go one better than last year's runner-up finish, sit in tied-second alongside Team Singh, as Justin Thomas and his father Mike set the pace with a brilliant 15-under 57.",
    picture: 'https://e1.365dm.com/22/12/768x432/skysports-tiger-woods-charlie-woods_5999830.jpg?20221217224111',
    picture_alt: 'Tiger Woods and his son Charlie sit two shots off the lead after the opening round of the 2022 PNC Championship',
    category: Category.find_by(title: "Golf"),
    subcategory: Subcategory.find_by(title: "Florida"),
    team: Team.find_by(title: "Florida Gators")
   },
   {headline: "World Cup: Man City pipped Chelsea and Man Utd to finish as top Premier League earners from tournament",
    caption: "Find out how much Premier League clubs earned from the World Cup; Man City were the top earners while Wolves came in seventh",
    content: "Premier League clubs will receive a cash boost from FIFA after sending their players off to the World Cup as part of the governing body's Club Benefits Programme.\nThis entitles clubs who were represented by players in Qatar to around $10,000 (£8,200) for every day individual players were away on international duty.\nThose who reached the final or third-place play-off earned their club around $370,000 (£304,000), while those who made the semi-final will earn around $320,000 (£263,000).\nA quarter-final place would see a player make $280,000 (£230,000) for their club, while a round-of-16 payment equates to around $220,000 (£181,000).\nFailure to progress from the group stages would still see a player earn $180,000 (£148,000) for their domestic side.\nHowever, if a player has moved within the last two years - including on loan - then the money will be split between the clubs involved. For example, Lisandro Martinez may be a Manchester United player now but Ajax stand to make more money - around two-thirds - from his run to the final with Argentina as they held his registration for seasons 2020/21 and 2021/22.",
    picture: 'https://e0.365dm.com/22/11/1600x900/skysports-marcus-rashford-england_5981859.jpg?20221129205015',
    picture_alt: 'Which Premier League club earned the most from the World Cup?',
    category: Category.find_by(title: "Football"),
    subcategory: Subcategory.find_by(title: "England"),
    team: Team.find_by(title: "Chelsea")
   }
]

articles.each do |article|
  new_article = Article.create!(headline: article[:headline],
                                caption: article[:caption],
                                content: article[:content],
                                picture_alt: article[:picture_alt],
                                category: article[:category],
                                subcategory: article[:subcategory],
                                team: article[:team],
                                is_part_of_main_articles: article[:is_part_of_main_articles],
                                is_part_of_breakdown: article[:is_part_of_breakdown])

  remote_picture = URI.open(article[:picture])
  new_article.picture.attach(io: remote_picture, filename: article[:picture_alt])
end
puts 'Articles have been added to each team from the NFL category!'
puts 'And one article added to each other category!'

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

static_page_articles = [
  {headline: "Meet Fallon Sherrock, the darts player beating men at their own game",
   caption: "Sherrock became the first woman to beat a man at a world championship.",
   content: "'I DON'T LOOK like the stereotypical darts player, do I?'' Fallon Sherrock says.\nIn her black flats, leggings and pink top, sipping from a glass of water before chucking her pink-flighted Tungsten darts at Robin Park Tennis Centre, the 25-year-old woman from Milton Keynes, a town about 54 miles north of London, is more anomaly than the norm.\nIt's 8:30 a.m., and the beer is flowing. The indoor facility is usually a veritable temple to fitness. But on this chilly mid-January morning in Wigan -- a town in Greater Manchester, England -- the grounds are being overrun by other darts players, who are, let's say, slightly less health-conscious.\nA makeshift bar is set up near one of the covered court baselines. Burly, mostly middle-aged blokes, many wearing loose, loud T-shirts bearing seemingly prerequisite nicknames such as The Candyman, Jellyfish and Grizzly, queue up in a snaking line for a liquid breakfast. You can take darts out of the pub, but you can never entirely take the pub out of darts.\nSherrock and the rest are on-site for an event in the four-day Q-school of the PDC (Professional Darts Corporation). Hundreds of players are out there, having paid their $580 entry fee, all trying to fulfill the dream of earning a card that will enable them to throw for big prizes as a darts professional on a burgeoning pro tour.",
   picture: 'https://a3.espncdn.com/combiner/i?img=%2Fphoto%2F2019%2F1218%2Fr642948_1296x518_5%2D2.jpg&w=920&h=368&scale=crop&cquality=80&location=origin&format=jpg',
   picture_alt: 'Fallon Sherrock in action at the PDC Darts World Championship in December.',
   category: Category.find_by(title: "Lifestyle")
  },
  {headline: "Jewell Loyd the latest WNBA star to dazzle with pregame fit",
   caption: "Itching to watch an underdog try to overcome the odds or triumph against adversity?",
   content: "When it comes to fashion, the WNBA is one of the better examples of athletes showing off their wardrobes. Many athletes have used their attire to support Phoenix Mercury star Brittney Griner, who has been detained in Russia since February after being arrested in a Moscow-area airport.\nSeveral WNBA stars have worn gear featuring Griner's face and jersey number along with pins that read 'We are BG.' On Tuesday, Griner's detention was extended until at least July 2.\nMore fashion statements have been made across The W this week. From trench coats to hockey jerseys, athletes have once again shown out on the pregame runway.",
   picture: 'https://a1.espncdn.com/combiner/i?img=%2Fphoto%2F2022%2F0617%2Fr1026375_1080x608_16-9.jpg&scale=crop&cquality=80&location=center',
   picture_alt: 'Loyd wore a graphic T-shirt featuring Los Angeles Lakers legend Kobe Bryant.',
   category: Category.find_by(title: "Lifestyle")
  },
  {headline: "Michael Brantley back to Astros on 1-year, $12M deal",
   caption: "$12 million deal with a chance to make $4 million more in incentives",
   content: "Free agent outfielder Michael Brantley is returning to the Houston Astros on a one-year, $12 million deal with a chance to make $4 million more in incentives, a source familiar with the situation told ESPN on Sunday.\nBrantley, 35, joined the Astros in 2019 and has been an instrumental part of their recent playoff runs both on the field and in the locker room. A right shoulder injury shortened his 2022 season; he played in only 64 games while missing the playoffs and underwent an arthroscopic labral repair in August.\nBrantley was effective while in the lineup last season, posting a .785 OPS with five home runs before getting hurt. He is a career .298 hitter in 14 seasons with an OPS just under .800.",
   picture: 'https://a.espncdn.com/combiner/i?img=/photo/2020/1130/r782594_1296x518_5-2.jpg&scale=crop&location=origin',
   picture_alt: 'FanSided first reported the agreement',
   category: Category.find_by(title: "Dealbook")
  },
  {headline: "Parramatta Eels lock in Dylan Brown on massive deal",
   caption: "Parramatta have signed Dylan Brown to a two-year contract extension in an important step towards breaking their premiership drought.",
   content: "The five-eighth's new deal includes an option to remain with the Eels until the end of the 2031 season, by which time he will be 31.\nAAP understands the Eels had been keen to make Brown an Eel for life but given he is still only 22, the player option offers flexibility to both parties.\nWith his previous contract expiring in 2023, Brown had been free to negotiate with rivals from November 1 but has now put an end to speculation he could move away from his junior club.\n'I left New Zealand to pursue an NRL career when I was 15, and the Eels have been home for me ever since,' said Brown, who will remain at Parramatta until at least 2025.\n'It's been an amazing journey so far, and the club has an exciting future that I want to be part of for a long time.\n'I'm grateful to be a part of this club, from Brad (coach Brad Arthur) and the coaches to my teammates, all the staff, our members and fans, I couldn't picture myself anywhere else.",
   picture: 'https://a.espncdn.com/combiner/i?img=%2Fphoto%2F2022%2F0923%2Fr1065761_1296x518_5%2D2.jpg&scale=crop&location=origin&format=jpg',
   picture_alt: 'Dylan Brown of the Eels passes during the NRL Preliminary Final',
   category: Category.find_by(title: "Dealbook")
  },
  {headline: "Rory McIlroy's three victories in 2022",
   caption: "He is the current world number one in the Official World Golf Ranking, and has spent over 100 weeks in that position during his career.",
   content: "After climbing back to world number one this year, relive Rory McIlroy's three wins at the Canadian Open, the Tour Championship and CJ Cup. You can watch Rory McIlroy on Sky Sports Golf at 9pm on Tuesday 20 December.",
   video_src: 'rory-mcilroy-win-2022.mp4',
   picture_alt: 'Rory McIlroy three victories',
   category: Category.find_by(title: "Video")
  },
  {headline: "Fans go wild as Argentina win the World Cup!",
   caption: "Argentina gets the world cup in Qatar 2022",
   content: "This is how Argentina fans celebrated their World Cup win...",
   video_src: 'argentina-world-cup-2022.mp4',
   picture_alt: 'Argentina wins the World Cup 2022',
   category: Category.find_by(title: "Video")
  },
]

static_page_articles.each do |article|
  new_article = Article.create!(headline: article[:headline],
                                caption: article[:caption],
                                content: article[:content],
                                picture_alt: article[:picture_alt],
                                category: article[:category])

  if article[:picture]
    remote_picture = URI.open(article[:picture])
    new_article.picture.attach(io: remote_picture, filename: article[:picture_alt])
  elsif article[:video_src]
    new_article.video.attach(io: File.open("#{Rails.root}/app/assets/videos/#{article[:video_src]}"), filename: article[:picture_alt])
  end
end
puts 'Articles have been added to each static page category!'

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