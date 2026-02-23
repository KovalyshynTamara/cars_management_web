FactoryBot.define do
  factory :user do
    email { FFaker::Internet.email }
    password { "password123" }
    full_name { FFaker::Name.name }
    password_confirmation { "password123" }
  end
end
