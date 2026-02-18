require "ffaker"

puts "Cleaning database..."
Car.destroy_all

makes = %w[Toyota BMW Audi Honda Ford Mazda Kia Nissan Volvo Lexus]
models = %w[Corolla Civic Focus Passat Camry Accord CXFive XTrail AClass]

puts "Creating cars..."

30.times do
  Car.create!(
    make: makes.sample,
    model: models.sample,
    year: rand(2005..2024),
    odometer: rand(10_000..200_000),
    price: rand(5_000..50_000),
    description: FFaker::Lorem.paragraph,
    date_added: rand(6.months.ago.to_date..Date.today)
  )
end

puts "Created #{Car.count} cars"
