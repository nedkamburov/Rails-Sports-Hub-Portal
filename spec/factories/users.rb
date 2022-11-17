FactoryBot.define do
  factory :user do
    name { 'John Doe' }
    sequence(:email) { |n| "johndoe+#{n}@email.com" }
    password { 'Pass@123' }
    confirmed_at  { Time.now }
    after(:build) do |user|
      user.avatar.attach(io: File.open(Rails.root.join('spec', 'factories', 'images', 'user-testing.png')), filename: 'user-avatar', content_type: 'image/png')
    end
  end

  factory :admin_user, parent: :user do
    role {'admin'}
  end
end