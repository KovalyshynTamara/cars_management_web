FactoryBot.define do
  factory :car do
    make { "BMW" }
    model { "X5" }
    year { 2020 }
    odometer { 50_000 }
    price { 25_000 }
    description { "Nice car" }
    date_added { Date.current }
  end
end
