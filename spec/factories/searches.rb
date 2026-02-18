FactoryBot.define do
  factory :search do
    association :user
    rules do
      {
        "make" => "BMW",
        "year_from" => "2018"
      }
    end
    requests_quantity { 1 }
  end
end
