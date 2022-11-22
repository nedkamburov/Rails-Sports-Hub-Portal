FactoryBot.define do
  factory :article do
     headline { "Lions owner expresses support for HC Dan Campbell, GM Brad Holmes following 1-5 start" }
     caption { "Itching to watch an underdog try to overcome the odds or triumph against adversity?" }
     content { "Lions owner Sheila Ford Hamp said Wednesday that she still believes in the leadership of head coach Dan Campbell and general manager Brad Holmes despite Detroit's slow start to the season, and that neither man's job is on the line. \nWhile Hamp told reporters that she relates to the frustration felt amongst the fanbase at the team's 1-5 start, she knows that systemic change takes time, and it wouldn't do anyone any good to be hasty with replacing people." }
     picture_alt { 'Lions-owner-picture' }
     category_id { FactoryBot.create(:category).id }
     subcategory_id { FactoryBot.create(:subcategory).id }
     team_id { FactoryBot.create(:team).id }
     after(:build) do |article|
       article.picture.attach(io: File.open(Rails.root.join('spec', 'factories', 'images', 'article-testing.jpeg')), filename: article[:picture_alt], content_type: 'image/jpeg')
     end
  end
end