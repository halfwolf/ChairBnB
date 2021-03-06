json.array! @conversations do |conv|
  json.user_id       conv.id
  json.name          conv.name
  json.user_icon     conv.avatar.url(:icon)
  json.messages      current_user.messages_with(conv.id)
end
