class Message < ActiveRecord::Base
  
  validates :sender_id, :receiver_id, :subject, presence: true
  
  belongs_to( :author,
    class_name: "User",
    foreign_key: :sender_id,
    primary_key: :id)
    
  belongs_to( :receiver,
    class_name: "User",
    foreign_key: :receiver_id,
    primary_key: :id)
  
  
end
