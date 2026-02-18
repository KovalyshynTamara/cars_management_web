# frozen_string_literal: true

FactoryBot.define do
  factory :search do
    rules { { make: "Toyota", min_price: 5000 }.to_json }
    association :user
  end
end
