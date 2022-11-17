FactoryBot.define do
  factory :category do
    title { 'NFL' }
    position { 1 }
    read_only { false }
    category_type { 'articles' }
  end

  factory :subcategory do
    title { 'AFC West' }
    position { 1 }
    association :category, factory: :category
  end

  factory :team do
    title { 'Memphis' }
    association :subcategory, factory: :subcategory
  end
end