# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Faker::Restaurant.name
# Faker::Restaurant.address.street_address
# Faker::PhoneNumber.phone_number_with_country_code
# Faker::Book.title
# Faker::Lorem.paragraphs
# Faker::LoremFlickr.image
# Create flats after clearing the database of all records
puts "Clearing database of records..."
Flat.destroy_all
puts "Now, #{Flat.count} records found of Flat record."
puts ".." * 20

5.times.with_index do |flat, index|
  Flat.create!(
    name: Faker::Lorem.sentence(word_count: rand(3..8)),
    address: Faker::Address.street_address,
    description: Faker::Lorem.paragraphs(number: rand(0..3)).join(''),
    price_per_night: rand(60..210),
    number_of_guests: rand(1..4)
  )
  puts "< Record ##{index} added >"
end

puts "--" * 20
flats = Flat.all

flats.each do |flat|
  puts "ID:#{flat.id} name:#{flat.name} add.: #{flat.address} desc.: #{flat.description[0..20]} E: #{flat.price_per_night} guests: #{flat.number_of_guests}"
end

puts "==" * 10

puts "<< DONE >>"