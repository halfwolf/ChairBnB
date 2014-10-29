class Review < ActiveRecord::Base
  
  validates :author_id, :reservation_id, :title, :rating, presence: true
  validates :reservation_id, uniqueness: true
  validates :rating, numericality: { greater_than: 0, less_than_or_equal_to: 5}
  
  
  belongs_to :reservation
  
  belongs_to( :author,
    class_name: "User",
    foreign_key: :author_id,
    primary_key: :id)
    
end
