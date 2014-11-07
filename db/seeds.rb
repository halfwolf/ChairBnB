# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#
6.times do
  User.create({
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: "password"
   })
end
#

ids = []
 User.all.each do |user|
   ids << user.id
 end


30.times do


  l = Listing.new({
    owner_id: ids.sample,
    name: Faker::Commerce.product_name,
    room_type: "outside",
    chair_type: "rocking",
    seats: 1,
    zip_code: Faker::Address.zip,
    price: 15
  })
  puts "heys"
  l.save!
end



Listing.all.each do |listing|
  b = listing.pictures.new()
  b.save!  
end