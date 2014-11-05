  json.current_user  current_user.id
  json.res_placed    current_user.reservations.any?{|res| res.chair_id == @listing.id }
  json.id            @listing.id
  json.name          @listing.name
  json.description   @listing.description
  json.owner_id      @listing.owner_id
  json.price         @listing.price
  json.room_type     @listing.room_type
  json.chair_type    @listing.chair_type
  json.address       @listing.full_address
  json.average_reviews @listing.average_reviews
  json.seats         @listing.seats
  json.owner         @listing.owner.name
  json.listing_pic   @listing.pictures.first.pic
  json.host_pic      @listing.owner.avatar.url(:icon)
