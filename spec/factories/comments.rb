FactoryBot.define do
  factory :comment do
    content { 'Great game!' }
    user { FactoryBot.create(:user) }
    article { FactoryBot.create(:article) }
  end

  factory :like do
    user { FactoryBot.build(:user) }
    association :likeable, factory: :comment
  end

  factory :dislike do
    user { FactoryBot.build(:user) }
    association :dislikeable, factory: :comment
  end
end