class Review < ActiveRecord::Base
  
  validates :author_id, :reservation_id, :title, presence: true
  validates :reservation_id, uniqueness: true
  
  
  belongs_to :reservation
  
  belongs_to( :author,
    class_name: "User",
    foreign_key: :author_id,
    primary_key: :id)
    
end
