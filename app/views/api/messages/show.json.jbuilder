json.self_id          @current_user.id
json.message do 
  json.author         message.author.name
  json.author_id      message.author.id
  json.author_pic     @message.author.avatar(:icon)
  json.receiver       message.receiver.name
  json.subject        message.subject
  json.body           message.body
  json.read           message.read
  json.send_date      message.created_at
end