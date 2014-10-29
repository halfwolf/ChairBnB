class Reservation < ActiveRecord::Base
  
  validates :chair_id, :start, :end, :sitter_id, :status, presence: true
  
  belongs_to( :sitter,
    class_name: "User",
    foreign_key: :sitter_id,
    primary_key: :id)
  
  belongs_to :chair, 
  class_name: "Listing",
  foreign_key: :chair_id,
  primary_key: :id
  
  has_one :review, dependent: :destroy

end
