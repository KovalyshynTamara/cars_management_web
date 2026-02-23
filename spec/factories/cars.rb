# frozen_string_literal: true

FactoryBot.define do
  factory :car do
    make { "Toyota" }
    model { "Corolla" }
    year { 2020 }
    odometer { 50_000 }
    price { 15_000 }
    description { "Reliable family car" }
    date_added { Date.current }
  end
end
