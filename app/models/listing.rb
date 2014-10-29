class Listing < ActiveRecord::Base
  validates :name, :location, :owner_id, :price, presence: true

  belongs_to( :owner,
  class_name: "User",
  foreign_key: :owner_id,
  primary_key: :id
  )

  has_many( :reservations,
    class_name: "Reservation",
    foreign_key: :chair_id,
    primary_key: :id)
    
  has_many :reviews, through: :reservations, source: :review
    
  def pending_reservations?
    self.reservations.where("status = 'PENDING'").length > 0
  end  
    
end
