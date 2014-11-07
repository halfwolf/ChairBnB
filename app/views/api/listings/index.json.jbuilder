json.array! @listings do |chair|
  json.id           chair.id
  json.name         chair.name
  json.description  chair.description
  json.owner_id     chair.owner_id
  json.price        '%.2f' % chair.price
  json.room_type    chair.room_type
  json.chair_type   chair.chair_type
  json.address      chair.full_address
  json.seats        chair.seats
  json.rating       chair.average_reviews
  json.listing_icon  chair.pictures.first.pic.url(:icon)
  json.listing_pic  chair.pictures.first.pic.url
  json.host_pic     chair.owner.avatar.url(:icon)
  json.geoJSON      chair.geoJSON
end