FactoryBot.define do
  factory :user do
    full_name { "John Doe" }
    email { FFaker::Internet.email }
    password { "password123" }
    role { "user" }

    trait :admin do
      role { "admin" }
    end
  end
end
