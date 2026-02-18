require "ffaker"

puts "Cleaning database..."

if ENV["ADMIN_EMAIL"].present? && ENV["ADMIN_PASSWORD"].present?
  admin = User.find_or_create_by!(email: ENV["ADMIN_EMAIL"]) do |user|
    user.password = ENV["ADMIN_PASSWORD"]
    user.password_confirmation = ENV["ADMIN_PASSWORD"]
    user.admin = true
  end

  puts "Admin created: #{admin.email}"
else
  puts "ADMIN ENV variables not set, skipping admin creation"
end

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
