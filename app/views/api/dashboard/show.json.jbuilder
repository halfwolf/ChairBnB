json.extract! current_user, :name, :id, :avatar
json.listings current_user.listings do |chair|
  json.id           chair.id
  json.name         chair.name
  json.price        chair.price
  json.description  chair.description
end

json.messages current_user.all_messages do |message|
  json.id           message.id
  json.sender_id    message.sender_id
  json.author       message.author.name
  json.receiver_id  message.receiver_id
  json.receiver     message.receiver.name
  json.subject      message.subject
  json.body         message.body
  json.read         message.read
end

json.reservations current_user.reservations do |res|
  json.id     res.id
  json.chair  res.chair
  json.status res.status
end

json.reviews current_user.all_reviews do |review|
  json.id         review.id
  json.author_id  review.author_id
  json.title      review.title
  json.body       review.body
  json.rating     review.rating
end

json.conversations current_user.conversations do |conv|
  json.user_id       conv.id
  json.name          conv.name
  json.user_icon     conv.avatar.url(:icon)
end
