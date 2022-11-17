FactoryBot.define do
  factory :article do
     headline { "Lions owner expresses support for HC Dan Campbell, GM Brad Holmes following 1-5 start" }
     caption { "Itching to watch an underdog try to overcome the odds or triumph against adversity?" }
     content { "Lions owner Sheila Ford Hamp said Wednesday that she still believes in the leadership of head coach Dan Campbell and general manager Brad Holmes despite Detroit's slow start to the season, and that neither man's job is on the line. \nWhile Hamp told reporters that she relates to the frustration felt amongst the fanbase at the team's 1-5 start, she knows that systemic change takes time, and it wouldn't do anyone any good to be hasty with replacing people." }
     picture { 'https://static.www.nfl.com/image/private/t_editorial_landscape_12_desktop/league/adbl0xyfjjvazdyfisnj' }
     picture_alt { 'Lions-owner-picture' }
     category { FactoryBot.create(:category) }
     subcategory { FactoryBot.create(:subcategory) }
     team { FactoryBot.create(:team) }
  end
end