json.array! @listings do |chair|
  json.id           chair.id
  json.name         chair.name
  json.description  chair.description
  json.owner_id     chair.owner_id
  json.price        chair.price
  json.room_type    chair.room_type
  json.chair_type   chair.chair_type
  json.address      chair.full_address
  json.seats        chair.seats
  json.listing_icon  chair.pictures.first.pic.url(:icon)
end
